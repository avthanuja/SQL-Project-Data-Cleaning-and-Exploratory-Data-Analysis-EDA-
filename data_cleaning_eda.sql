-- SQL Project - Data Cleaning and EDA

-- Dataset: https://www.kaggle.com/datasets/swaptr/layoffs-2022

-- 1. Create a Staging Table
CREATE TABLE world_layoffs.layoffs_staging LIKE world_layoffs.layoffs;
INSERT INTO world_layoffs.layoffs_staging SELECT * FROM world_layoffs.layoffs;

-- 2. Remove Duplicates
WITH DELETE_CTE AS (
    SELECT *, ROW_NUMBER() OVER (
        PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
    ) AS row_num FROM world_layoffs.layoffs_staging
)
DELETE FROM world_layoffs.layoffs_staging WHERE (company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions, row_num) IN (
    SELECT company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions, row_num FROM DELETE_CTE
) AND row_num > 1;

-- 3. Standardize Industry Data
UPDATE world_layoffs.layoffs_staging SET industry = NULL WHERE industry = '';
UPDATE world_layoffs.layoffs_staging t1 JOIN world_layoffs.layoffs_staging t2 ON t1.company = t2.company 
SET t1.industry = t2.industry WHERE t1.industry IS NULL AND t2.industry IS NOT NULL;
UPDATE world_layoffs.layoffs_staging SET industry = 'Crypto' WHERE industry IN ('Crypto Currency', 'CryptoCurrency');

-- 4. Standardize Country Names
UPDATE world_layoffs.layoffs_staging SET country = TRIM(TRAILING '.' FROM country);

-- 5. Convert Date Column to Proper Format
UPDATE world_layoffs.layoffs_staging SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');
ALTER TABLE world_layoffs.layoffs_staging MODIFY COLUMN `date` DATE;

-- 6. Remove Unnecessary Rows
DELETE FROM world_layoffs.layoffs_staging WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

-- 7. Exploratory Data Analysis (EDA)

-- Find the max and min layoffs
SELECT MAX(total_laid_off), MIN(total_laid_off) FROM world_layoffs.layoffs_staging;

-- Companies with the most layoffs
SELECT company, SUM(total_laid_off) FROM world_layoffs.layoffs_staging GROUP BY company ORDER BY 2 DESC LIMIT 10;

-- Layoffs by Country
SELECT country, SUM(total_laid_off) FROM world_layoffs.layoffs_staging GROUP BY country ORDER BY 2 DESC;

-- Layoffs by Year
SELECT YEAR(date), SUM(total_laid_off) FROM world_layoffs.layoffs_staging GROUP BY YEAR(date) ORDER BY 1 ASC;

-- Industry-wide layoffs
SELECT industry, SUM(total_laid_off) FROM world_layoffs.layoffs_staging GROUP BY industry ORDER BY 2 DESC;

-- Rolling total layoffs per month
WITH DATE_CTE AS (
    SELECT SUBSTRING(date,1,7) AS dates, SUM(total_laid_off) AS total_laid_off FROM world_layoffs.layoffs_staging GROUP BY dates ORDER BY dates ASC
)
SELECT dates, SUM(total_laid_off) OVER (ORDER BY dates ASC) AS rolling_total_layoffs FROM DATE_CTE ORDER BY dates ASC;
