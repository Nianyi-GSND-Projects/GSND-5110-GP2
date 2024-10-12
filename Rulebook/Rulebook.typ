#set page(
	paper: "us-letter", flipped: true,
	margin: 0.5in,
	columns: 2,
)
#set text(size: 10pt)
#set par(linebreaks: "optimized")
#set list(spacing: 0em)

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

= Overview

#columns(2)[
	- A turn-based board game.
	- For 2-4 players.
	#colbreak()
	- Cooperative and fun.
	- Involves physical interaction.
]

You play a chef working in a kitchen.
Try to finish as many orders as possible in limited turns with your friends!

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

+ Place all the kitchenware, ingredients boxes,and tables accessories on the map.

	#cph()#cph()#cph()

+ Place your chef markers into the starting spots.

+ Place all the ingredient tokens aside.

After preparation, the board should look like this:

#figure(placeholder(height: 12em)[placeholder])

= Play

The game is played in turns, cycling between the players.
The order goes as the chef's positions on the map.
== Game area
The game contains three different area.
- Main game area

Main game area contains the map board and everything on it or attached to it.

- Order area

Order pile, active orders and finished orders are put together in order area.

- Player area

Each player has their own player area. Ingredients tokens will be placed here to represent it is being held by this player.

== New order

Every time before the first player starts their turn, draw 1 card from the order pile, put it facing up aside to represent an active order.

What kinds of ingredients and how they should be processed to finish an order will be drawn on the order card.
There will also be two integer numbers on the card representing the validity period and score rewards of the order.

The validity period shows that an order would expire if not finished after certain rounds.
The score reward show that how many scores will players gain when this order is completed.
//Use the following table to determine after how many round would an order expire.

//#placeholder()[table];

== Player's turn

In each player's turn, they could choose from one of the following options:

- Flick his own chef marker once to move on the map.

- Spend the turn to finish a processing action(only when the player's chef marker is in any kitchenware's activation area).

- Do nothing.

Each turn has a time limit of *10* seconds. If a player doesn't make their choice before the time ends, they are considered to do nothing this turn.

At the end of each turn, all orders expires should be removed from game.

== Flick and Hit

Players move their chef markers by flicking them. 

When one's chef marker hit the ingredients accessories, they can choose to pick up one certain ingredient token and place it in their own player area.

When one's chef marker hit the table accessory, they can choose to put any of ingredient tokens from their player area to the top of table accessory, or they can also put any of ingredient tokens from top of the table accessory to their player area.

== Processing the ingredients
Each kitchenware has its own activation area. When player's marker is in the area, they can choose to spend a whole turn to process an ingredient token in their player area.

When an ingredient token is processed, it should be fliped to the processed side to represent it.
// Different ingredients may need to be processed by different kitchenware.

== Finish Order and Win the Level
Whenever ingredients in players' areas have met the need of a certain active order, players can spend ingredients on that order cards to complete that order. 

Once an order is completed, it should be moved from active orders to a completed order pile. It is no longer avtive during the rest of game.

When the order pile is empty, and there is no active order in the order area, the game ends. The score rewards on all orders in completed order pile will be summed. If the total sum of the scores meets the requirement of the level, players win this level. Otherwise, they fail the game.

