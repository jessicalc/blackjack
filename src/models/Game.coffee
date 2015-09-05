class window.Game extends Backbone.Model
  initialize: ->
    @newGame()
    @set 'inPlay', true
    @get('playerHand').on "playerBusted", @togglePlaying
    @get('dealerHand').on "stand", @togglePlaying
    @set 'balance', 20

  newGame: ->
    ## starts a new game like the first time the game starts
    @set 'deck', deck = new Deck()
    @newRound()

  newRound: ->
    ## starts a new round with the same deck
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @set 'inPlay', true

  togglePlaying: =>
    @set 'inPlay', !@get 'inPlay'

  updateBalance: (bet) ->
    @set 'balance', @get 'balance' + bet