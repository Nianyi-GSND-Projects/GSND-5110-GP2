#set page(
	paper: "us-letter", flipped: true,
	margin: 0.5in,
	columns: 2,
)
#set par(linebreaks: "optimized")
#set heading(numbering: "1.1.1")

#let placeholder(body, width: 100%, height: 1in) = {
	box(width: width, height: height, stroke: (black + 0.5pt))[#{
		set align(horizon + center);
		body;
	}]
}

#let title = [The Rule Book of _Tabletop Overcooked!_]
#let version = "0.1.0"

#{
	show par: set block(below: 0.8em);
	set align(center);
	{
		set text(size: 18pt, weight: "bold");
		title;
	}
	parbreak();
	set text(style: "italic");
	[version #version]
};

A group of chefs are working in a kitchen.
Try to finish orders as fast as possible!

= Overview

#columns(2)[
	- A turn-based board game.
	- For 2-4 players.
	#colbreak()
	- Cooperative and fun.
	- Involves physical interaction.
]

= Setup

#let cph() = {
	placeholder(width: 2em, height: 2em)[];
}
#let rarrow() = {
	box(width: 2em, height: 2em)[
		#set align(center + horizon)
		→
	];
}

+ Pick a map board and place it on a flat surface.

+ Shuffle the order pile and place it facing down in the order area.

	#cph()#rarrow()#cph()
	#h(1em)
	#cph()#rarrow()#cph()
	#h(1em)
	#cph()#rarrow()#cph()

+ Place all ingredients in the corresponding ingredient boxes on the map.

	#cph()#cph()#cph()

+ Place the chef markers into the starting spots.

+ Place all the ingredient tokens aside.

After preparation, the board should look like this:

#figure(placeholder(height: 12em)[placeholder])

== Areas

There are 3 areas that can be seen from the setup:

- Map board:
	Supports the gameplay and displays everything.
- Order area:
	Where the active orders and finished orders are placed.
- Hand:
	The players could hold ingredients in hand.

= Play

The game is played in turns, cycling between the players.
The order goes as the chef's positions on the map.

== New order

Before the first player's turn starts, draw 1 card from the order pile and place it on the table facing up, which would be the first incoming order.
There are some important information shown on the card:
- The ingredients required for this order.
- The waiting turn number of this order.
- The scores the players could get for finishing this order.
Every 6 rounds, a new order will come in.

Upon a turn, a player could choose one option below:
- Move their chef marker (see @Movement).
- Perform a workspot action (see @Workspot).
- Do nothing and skip the turn.

Each turn is limited to 10 seconds, So the player must finish their action within the time range, or the turn will automatically be skipped.

At the end of each turn, discard all expired orders.

== Movement
<Movement>

A player could move their own chef marker by flicking them with fingers.
In each turn, a player may only flick once.

Before flicking, if the chef is holding anything, they may drop them at place.

After flicking, if anything is hit during the chef marker's movement, the player could pick it up by putting _only one of them_ on the chef marker (only if the chef is not holding anything).

== Workspot
<Workspot>

Every workspots come with their areas.
When a player's chef marker is overlapping a workspot area, they could spend a turn to process an ingredient they're holding.
When an ingredient is processed, it should be flipped to the processed side.

== Serving

When an active order's all requirements are met, players could spend the ingredients they're holding to complete it.
The order then should be move to the completed order pile.

== Finishing

When all orders are either finished or expired, the game ends.

The result of the game is determined by whether the final score has reached the level's required passing score.
Sum all scores of the finished orders to get the final score.

= Appendix

#show table.cell.where(y: 0): set text(weight: "bold")

== Term table

#table(
	columns: 2,
	align: left,
	stroke: none,

	table.hline(),
	table.header([#set align(center); Term], [#set align(center); Meaning]),
	table.hline(stroke: 0.5pt),

	[Map board], [
		A "level" of this game.
		Features a planar structure with obstacles to block the chefs' movement.
	],
	[Ingredient box], [
		A containing area on the map where the players could take ingredient from.
	],
	[Hand], [
		Where a player holds the game objects they own.
	],
	[Chef marker], [
		A small round disk with some weight to represent a player's avatar in the game.
	],
	[Workspot], [
		An area on the map where the players can process the ingredients to the next stage.
	],

	table.hline(),
)