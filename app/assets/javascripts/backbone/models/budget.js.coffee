class Greenback.Models.Budget extends Backbone.Model
	urlRoot: "/api/budgets"
	defaults:
		name: "Untitled Budget"

class Greenback.Collections.Budgets extends Backbone.Collection
  url: "/api/budgets"
  model: Greenback.Models.Budget
  parse: (response) =>
    response.reverse()

class Greenback.Collections.BudgetHistory extends Backbone.Collection
  model: Greenback.Models.Budget
  url: "/api/budgets"

  parse: (response) =>
    response.reverse()
