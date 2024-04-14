window.addEventListener('turbo:load', setupPriceInputHandler);

function setupPriceInputHandler() {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", handlePriceInput);
}

function handlePriceInput() {
  const inputValue = getInputValue();
  updateTaxDisplay(inputValue);
  updateProfitDisplay(inputValue);
}

function getInputValue() {
  const priceInput = document.getElementById("item-price");
  return Math.floor(priceInput.value);
}

function updateTaxDisplay(inputValue) {
  const tax = calculateTax(inputValue);
  const addTaxDom = document.getElementById("add-tax-price");
  addTaxDom.innerHTML = tax.toLocaleString();
}

function calculateTax(inputValue) {
  return Math.floor(inputValue / 10);
}

function updateProfitDisplay(inputValue) {
  const profit = calculateProfit(inputValue);
  const profitDom = document.getElementById("profit");
  profitDom.innerHTML = profit.toLocaleString();
}

function calculateProfit(inputValue) {
  const tax = calculateTax(inputValue);
  return inputValue - tax;
}