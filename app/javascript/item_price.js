function calculate (){
  const priceInput = document.getElementById("item-price");
  const displayPriceElement = document.getElementById("add-tax-price");
  const displayProfitElement = document.getElementById("profit");

priceInput.addEventListener("input", () => {
   const inputValue = priceInput.value;
   const commissionValue = Math.floor(inputValue * 0.1).toLocaleString();
   const profitValue = Math.floor(inputValue * 0.9).toLocaleString();
   displayPriceElement.innerHTML = commissionValue;
   displayProfitElement.innerHTML = profitValue;
})
}

window.addEventListener('turbo:load', calculate);
