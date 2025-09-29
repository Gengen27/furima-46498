document.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  if (priceInput) {
    priceInput.addEventListener("input", () => {
      const price = parseInt(priceInput.value);

      if (!isNaN(price) && price >= 300 && price <= 9999999) {
        const fee = Math.floor(price * 0.1); // 販売手数料 10%
        const gain = price - fee;             // 利益
        addTaxPrice.textContent = fee;
        profit.textContent = gain;
      } else {
        addTaxPrice.textContent = "0";
        profit.textContent = "0";
      }
    });
  }
});
