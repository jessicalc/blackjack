class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @collection.on 'playerBusted', -> alert 'you went bust!'
    @collection.on 'dealerBusted', -> alert 'dealer went bust'
    @render()

    # events:
    # 'click .hit-button': -> @model.get('game').get('playerHand').hit()
    # # perhaps change this to dealer hand
    # 'click .stand-button': -> @model.get('game').get('playerHand').stand()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]

