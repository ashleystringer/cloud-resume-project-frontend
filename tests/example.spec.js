// @ts-check
import { test, expect } from '@playwright/test';
import 'dotenv/config'

console.log(`WEBSITE_URL: ${process.env.WEBSITE_URL}`);

test('has title', async ({ page }) => {
  await page.goto(`${process.env.WEBSITE_URL}`);

  // Expect a title "to contain" a substring.
  await expect(page).toHaveTitle(/Resume Site/);
  
  const name = page.locator('.name');
  await expect(name).toHaveText(/Ashley Stringer/);
});

test('has number in Vistor Count', async ({ page }) => {
  await page.goto(`${process.env.WEBSITE_URL}`);

  const visitorCount = page.locator(".visitor-count-display");
  await expect(visitorCount).toHaveText(/Visitor Count: \d+/);
});
