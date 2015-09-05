class window.ScoreboardView extends Backbone.View
  template: _.template '
    <div class="scoreboard">
      <h3>Money</h3>
      <div class="bets">
        <form>
        <h4>Current Bet</h4>
        <ul>
          <li><input type="radio" value="1" name="bet"> $1</li>
          <li><input type="radio" value="5" name="bet"> $5</li>
          <li><input type="radio" value="10" name="bet"> $10</li>
        </ul>
        </form>
      </div> 
      <div class="balance">
        <h4>Balance</h4>
        <%- balance %>
      </div>
    </div>
  '
  events:
    'click .hit-button': -> 
    #   if @model.get('game').get 'inPlay'
    #     @model.get('game').get('playerHand').hit()

  initialize: ->
    @render()

  render: ->
    @$el.html @template(@model.attributes)