window.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = Math.floor(priceInput.value);
    const addTaxDom = document.getElementById("add-tax-price");
    const tax = Math.floor(inputValue / 10);
    addTaxDom.innerHTML = (tax).toLocaleString();
    const profitDom = document.getElementById("profit");
    profitDom.innerHTML = (inputValue - tax).toLocaleString();
  });
})