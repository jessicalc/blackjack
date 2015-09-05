class window.Card extends Backbone.Model
  initialize: (params) ->
    @set
      revealed: true
      # the params come from the Deck model, when we instantiated new cards with an object with rank and suit properties
      value: if !params.rank or 10 < params.rank then 10 else params.rank
      suitName: ['spades', 'diamonds', 'clubs', 'hearts'][params.suit]
      rankName: switch params.rank
        when 0 then 'king'
        when 1 then 'ace'
        when 11 then 'jack'
        when 12 then 'queen'
        else params.rank

  flip: ->
    # this.set('revealed', !this.get('revealed'))
    @set 'revealed', !@get 'revealed'
    @
