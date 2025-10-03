const priceCalculation = () => {
  const priceInput = document.getElementById('item-price');
  if (!priceInput) return;
  
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");
    
    // 要素が存在しない場合は処理を中断
    if (!addTaxDom || !profitDom) return;
    
    const price = parseInt(inputValue, 10);
    
    if (!isNaN(price)) {
      const fee = Math.floor(price * 0.1);
      const profit = price - fee;
      addTaxDom.innerHTML = fee.toLocaleString();
      profitDom.innerHTML = profit.toLocaleString();
    } else {
      // 入力が数値でない場合（空文字など）は表示をリセット
      addTaxDom.innerHTML = 'ー';
      profitDom.innerHTML = 'ー';
    }
  })
};
window.addEventListener('turbo:load', priceCalculation);
