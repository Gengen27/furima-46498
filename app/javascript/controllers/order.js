document.addEventListener("turbo:load", function() {
  const form = document.getElementById("charge-form");
  if (!form) return; // form がないページでは処理しない

  // Payjp 初期化
  const payjp = Payjp(gon.public_key);
  const elements = payjp.elements();

  // 各入力欄を生成してマウント
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  // フォーム送信時の処理
  form.addEventListener('submit', function(e) {
    e.preventDefault();

    payjp.createToken(numberElement).then(function(response) {
      if (response.error) {
        alert("カード情報が正しく入力されていません。");
      } else {
        // トークンをフォームに追加
        const tokenInput = document.createElement('input');
        tokenInput.setAttribute('type', 'hidden');
        tokenInput.setAttribute('name', 'token');
        tokenInput.setAttribute('value', response.id);
        form.appendChild(tokenInput);

        form.submit(); // 通常送信
      }
    });
  });
});









