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

+ Place the ingredient piles at places matching their types.

	#cph()#rarrow()#cph()
	#h(1em)
	#cph()#rarrow()#cph()
	#h(1em)
	#cph()#rarrow()#cph()

+ Place the chopping board markers.

	#cph()#cph()

+ Place the pots on the stoves and place the cooking markers.

	#cph()#cph()#cph()

+ Shuffle the three ingredient decks and place them on the table facing down.

+ Place your chef markers into the starting spots.

After preparation, the board should look like this:

#figure(placeholder(height: 12em)[placeholder])

= Play

The game is played in turns, cycling between the players.
The order goes as the chef's positions on the map.

== New order

Before the first player starts their turn, draw 1 card from each ingredient pile, put them together to make a order.
Each card represents one portion of the ingredients needed for the dish.
If a card is empty, then that pirtion is not needed for this order.

An order would expire if not finished after certain rounds.
Use the following table to determine after how many round would an order expire.

#placeholder()[table];

== Player's turn

In each player's turn, they could choose from one of the following options:

- Move (or do nothing).
- Start performing an action.
- Wait for an action to finish.