class window.AppView extends Backbone.View
  template: _.template '
    <div class="container">
      <div class="game-container">
        <h1>Black Jack</h1>
        <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
        <button class="new-round">New Round</button> <button class="new-game">New Game</button>
        <div class="player-hand-container"></div>
        <div class="dealer-hand-container"></div>
      </div>
      <div class="scoreboard-container">
      </div>
    </div>
  '
  events:
    'click .hit-button': -> 
      if @model.get('game').get 'inPlay'
        @model.get('game').get('playerHand').hit()
    # perhaps change this to dealer hand
    'click .stand-button': ->
      if @model.get('game').get 'inPlay'
        @model.get('game').get('dealerHand').stand()
    'click .new-round': ->
      if @model.get('game').get('deck').length > 15
        @model.get('game').newRound()
      # shuffle the cards if you start with less than 15 cards but keep score
      else @model.get('game').set 'deck', deck = new Deck() 
      @render()
    'click .new-game': ->
      @model.get('game').newGame()
      @render()


  initialize: ->
    @model.get('game').get('dealerHand').on 'endGame', ->
      @render()
      dealerScore = @model.get('game').get('dealerHand').minScore();
      playerScore = @model.get('game').get('playerHand').minScore();
      winner = if playerScore > dealerScore then "player" else "dealer"
      setTimeout ->
        alert "dealerScore is: #{dealerScore} and playerScore is: #{playerScore}
          #{winner} wins!"
      , 10
    , @
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get('game').get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get('game').get 'dealerHand').el
    @$('.scoreboard-container').html new ScoreboardView(model: @model.get('game')).el

