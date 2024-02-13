function calculate (){
  const priceInput = document.getElementById("item-price");
  const displayPriceElement = document.getElementById("add-tax-price");
  const displayProfitElement = document.getElementById("profit");

  priceInput.addEventListener("input", () => {
    const inputValue = parseFloat(priceInput.value);
    const commissionValue = Math.floor(inputValue * 0.1);
    const profitValue = Math.floor(inputValue - commissionValue).toLocaleString();
    displayPriceElement.innerHTML = commissionValue.toLocaleString(); 
    displayProfitElement.innerHTML = profitValue;
});
}
window.addEventListener('turbo:load', calculate);
window.addEventListener("turbo:render", calculate);
