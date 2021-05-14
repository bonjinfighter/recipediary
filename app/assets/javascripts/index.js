     // YouTube APIの読み込み
      var tag = document.createElement('script');
      tag.src = "https://www.youtube.com/iframe_api";
      var firstScriptTag = document.getElementsByTagName('script')[0];
      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
 
      //iframe player APIコードを非同期で読み込みます。
      var player;
 
      function onYouTubeIframeAPIReady() {
          //動画を埋め込む場所を指定(1.のidを入れる)
          player = new YT.Player('yt_player', {
              //YouTUbeの動画IDを入れる
              videoId: 'kLxnApfyFB4?modestbranding=1',
              //オプションを設定する場所
              playerVars: {
                  playsinline: 1,
                  loop: 1,
                  listType: 'playlist',
                  playlist: 'kLxnApfyFB4?modestbranding=1', //上と同じ動画ID_リピートするには入力必須
                  rel: 0, // 関連動画の非表示
                  controls: 0, // 動画プレーヤーのコントロール非表示
              },
 
              events: {
                  'onReady': onPlayerReady,
                  'onStateChange': onPlayerStateChange
              }
          });
      }
 
      //プレーヤの準備完了後に呼び出す関数
      function onPlayerReady(event) {
          event.target.mute(); //ミュートにしないとスマホで再生されない
          event.target.playVideo(); //ビデオを再生
      }
      var done = false;
 
      function onPlayerStateChange(event) {
          var ytStatus = event.target.getPlayerState();
          if (ytStatus == YT.PlayerState.ENDED) {
              event.target.mute(); //ミュートにしないとスマホで再生されない
              event.target.playVideo(); //ビデオを再生
          }
      }
