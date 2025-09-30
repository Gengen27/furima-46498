// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@rails/request.js"

document.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById('item-price');
  const addTaxPrice = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');

  if (!priceInput) return; // 該当ページ以外では処理しない

  priceInput.addEventListener('input', () => {
    const value = parseInt(priceInput.value, 10);

    if (isNaN(value) || value < 300 || value > 9999999) {
      addTaxPrice.textContent = '0';
      profit.textContent = '0';
      return;
    }

    const fee = Math.floor(value * 0.1); // 手数料10％
    const gain = value - fee;            // 利益

    addTaxPrice.textContent = fee.toLocaleString();
    profit.textContent = gain.toLocaleString();
  });
});

