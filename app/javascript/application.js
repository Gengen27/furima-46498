// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@rails/request.js"

document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById('item-price');
  const addTaxPrice = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');

  if (!priceInput) return; // 該当ページ以外では処理しない

  priceInput.addEventListener('input', () => {
    const value = parseInt(priceInput.value, 10);

    if (isNaN(value) || value < 0) {
      addTaxPrice.textContent = '0';
      profit.textContent = '0';
      return;
    }

    // 手数料10％（小数切り捨て）
    const fee = Math.floor(value * 0.1);
    // 利益
    const gain = value - fee;

    addTaxPrice.textContent = fee.toLocaleString();
    profit.textContent = gain.toLocaleString();
  });
});
