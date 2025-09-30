const calculatePrice = () => {
  const priceInput = document.getElementById('item-price'); // 実際の input id に合わせる
  const feeDisplay = document.getElementById('add-tax-price');
  const profitDisplay = document.getElementById('profit');

  if (!priceInput) return;

  priceInput.addEventListener('input', () => {
    const price = parseInt(priceInput.value, 10);
    if (!isNaN(price)) {
      const fee = Math.floor(price * 0.1);
      const profit = price - fee;
      feeDisplay.textContent = fee;
      profitDisplay.textContent = profit;
    } else {
      feeDisplay.textContent = 0;
      profitDisplay.textContent = 0;
    }
  });
};


document.addEventListener('turbo:load', calculatePrice);
document.addEventListener('turbo:render', calculatePrice);

