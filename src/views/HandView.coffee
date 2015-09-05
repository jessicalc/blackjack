class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @render()
    @collection.on 'add remove change', => @render()
    @collection.on 'playerBusted', =>
      @render()
      setTimeout ->
        alert 'you went bust!'
      , 10
    @collection.on 'dealerBusted', =>
      @render()
      setTimeout ->
        alert 'dealer went bust'
      , 10

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

