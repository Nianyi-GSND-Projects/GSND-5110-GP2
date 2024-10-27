// Preambles

#set page(paper: "us-letter", margin: 1in)
#set par(justify: true)
#show text.where(lang: "zh"): set text(font: "KaiTi")
#set heading(numbering: "1.1.1")
#show heading.where(level: 1): it => {
	set align(center);
	set text(size: 16pt);
	v(0.5em);
	it;
	v(0.5em);
}
#set quote(quotes: true)
#show quote: set text(style: "italic")
#let ilink = (href, body) => {
	show link: set text(fill: blue);
	show link: underline;
	link(href, body);
}
#show math.equation.where(block: true): set math.equation(numbering: "1")
#set table(stroke: none)
#show table.cell.where(y: 0): it => {
	set text(weight: "bold");
	set align(center);
	it;
}

// Title

#((title, subtitle) => {
	set align(center);
	par(text(size: 19pt, weight: "bold")[#title]);
	v(-1em);
	par(text()[#subtitle]);
	{
		box(
			width: 50%,
			grid(
				columns: (1fr, 1fr),
				row-gutter: 1em,
				ilink("https://trello.com/invite/b/6701e44779ec640c5d328f0e/ATTI2e4e5c2ac806f734622a4564c54e84232C3A9BAB/group-project-2-prototyping-and-balancing")[Trello Board],
				ilink("https://github.com/Nianyi-GSND-Projects/GSND-5110-GP2/blob/master/Team%20Log/Team%20Log.md")[Team Log],
				ilink("https://www.youtube.com/watch?v=45iAqECxuNI")[Introduction Video],
				ilink("https://www.youtube.com/watch?v=nxQ1l2dCgHg")[Playthrough Video],
			)
		);
	}
})[
	Concept Document for _Overcooked! Tabletop_
][
	Group Project \#2 for GSND 5110, Group \#6
];

#heading(level: 1, numbering: none)[Group Members]

#{
	set align(center);
	v(-0.5em);
	text(style: "italic")[(by alphabetical order of first name)];
}

#{
	let member(name: "", localname: "", mail: "", roles: "") = {
		set align(center);

		{
			show link: set text(size: 0.9em, font: "Consolas", fill: black);
			text()[#name (#localname)];
			linebreak();
			text[#link("mailto:" + mail)[<#mail>]];
		}

		linebreak();
		text(roles);
	};
	
	grid(
		columns: (1fr, 1fr),
		row-gutter: 2em,
		member(
			name: "Nian'yi Wang",
			localname: text(lang: "zh")[王念一],
			mail: "wang.nian@northeastern.edu",
			roles: [Project Manager, Editor],
		),
		member(
			name: "Siyu Chai",
			localname: text(lang: "zh")[柴思宇],
			mail: "chai.siyu@northeastern.edu",
			roles: [Map Designer],
		),
		member(
			name: "Yichi Zhang",
			localname: text(lang: "zh")[张亦驰],
			mail: "zhang.yichi13@northeastern.edu",
			roles: [Mechanism Designer],
		),
		member(
			name: "Zixun Yan",
			localname: text(lang: "zh")[严子迅],
			mail: "yan.zixun@northeastern.edu",
			roles: [Artist],
		),
	);
}

#outline(
	indent: auto,
	depth: 2,
	target: heading.where(numbering: "1.1.1"),
)
#pagebreak()

= Overview

_Overcooked! Tabletop_ is a table-top adaptation of the popular party video game _Overcooked!_.
The players play as chefs working in a kitchen to finish the orders coming in from the customers.
They must cooperate well to finish their works on time.

Our adapted prototype focuses on recreating and delivering the experience of cooperating with friends that comes from the original gameplay.
To achieve this, we designed a turn-based mechanism that encourages the players to adapt a cooperative strategy on splitting the work, while keeping the intension by setting up a global time limitation for the entire level, as long as individual limitations for every orders.

= Game Dissection

== Quick Facts

- Genre: Multiplayer cooperative party game.
- Camera: Adopts a pseudo top-down view.
- Map: Grid-based, but the players could move freely.
- Goal: To cook and serve as many orders as possible within limited time.

== A Closer Look

The game resembles the kitchen of a restaurant, in which the players would play as chefs to finish the orders keep coming in.

#figure(
	caption: [Level 1-1 of _Overcooked!_.],
	image("images/level-1-1-labeled.jpg", height: 20em)
) <fig:level-1-1>

@fig:level-1-1 shows the first level of _Overcooked!_, with the steps that the players need to do labelled in sequence:

+ Take the onions out from the basket.
+ Take them to the cutting board and cut them.
+ Put the cut onion into the pot.
+ Set the pot on stove and wait for it to be cooked.
+ Pour the soup into the plate before the pot's burnt.
+ Take the plate to the serving table.
+ Collect the dirty dishes from the recycling window to the sink.
+ Wash them in the sink and put them back on empty desks.
+ If anything goes wrong, there's a bin to dispose unwanted items or burnt soup.

It's easy to see that if players really follow through all the steps, they would be taking unnecessarily long routes all the time.
So, instead of each chef does all the steps individually, an obviously more reasonable strategy is to split the work up by each chef taking the works on one side of the kitchen (divided by the line of desks in the middle horizontally), so that neither one needs to walk long distances anymore.

A possible working plan would be like:
Chef A is in charge of taking the ingredients, putting cut ingredients in pots, getting them cooked and passing cooked soups to over the desks;
while chef B is in charge of cutting ingredients passed by chef A, passing them back, taking the cooked soup to the dishes, returning the pot, serving the dishes and cleaning the returned dirty dishes.

Naturally, players would form up a cooperative strategy instead of working on their own business independently.
There are couple of factors of the game that causes this.
Most of them are challenges to the players.

=== Temporal

Temporal challenge is the most founding element for the game play.
Without this, the whole game mechanism doesn't stand anymore, as the player could just walk around and do everything at an easy pace.

From outside, there are limitations for the entire level and each order, pushing the players to find the fastest way to finish the orders.
From inside, each step in the cooking procedure would cost fixed amount of time, as long as the necessary walkings.

=== Spatial

Spatial challenge isn't only reflected on the map, but also fixed-amount resources, like desk space, usable clean disks, pots, chopping boards, etc.
The players must plan the usage of these resources wisely or otherwise they'd quickly be short on them, dragging down the entire cooking procedure.
This could be fatal because each cooking step are linked with one another, and the clock is still running when the procedure is stuck.

Also, the route planning thing mentioned earlier.
The level designer intentionally designed the map to be inconvenient for one chef to take care of the entire procedure, so it's necessary for multiple chefs to split the work.
There could be other spatial tricks like a narrow passageway where only one chef could pass at a time; or conveyer belts which would move objects around.

=== Strategical

There's a strategy often used in real gameplay: batching.
Instead of doing orders one by one, it could save some time if the same steps are batched together.
It also saves some mental stress because the chef in charge of using the pots doesn't have to take care of them as frequently as if each pot is used individually---they work in sync now.

== MDA Analysis

There are 3 main aspects of the aesthetics that we can extract from the game, as shown in @table:mda.

#figure(
	caption: [The MDA analysis of the game.],
	table(
		columns: 3,
		align: (center, left, left),
		table.hline(),
		table.header([Aesthetic], [Dynamic], [Mechanics]),
		table.hline(stroke: 0.5pt),
		[Cooperation],
		[The players need to cooperate to get works done effectively.],
		[By passing items via tables, throwing, streamlining; supported by the map design of levels.],
		[Conflict],
		[If not cooperting well, consequences would follow to drag down the effeciency significantly.],
		[One working spot is only available for one player at a time, also the narrow passageways.],
		[Chaos],
		[The fast pace of the game makes it impossible for the players to sufficiently exchange their thoughts and plans. It'll also punish delayed actions, making the game chaotic.],
		[The time limit of the level as well as the orders; over-cooked ingredient will need to be disposed and cause fire.],
		table.hline(),
	),
) <table:mda>

After analysis, we think that the essence of _Overcooked!_ is generated from the cooperation with friends and facing the challenges from the level.
Although the chaotic gameplay and the conflict caused by failing cooperation is also a part of the experience, we would argue that they are not as essential as cooperation.
We want to recreate this experience of reaching a tacit agreement with friends by planning the actions and overcome the difficult levels, and also avoid the conflicts.
This is reflected in the goal of our game protoype, its movement rules and the interactable environmental objects.

= Mechanism Design

== Components

- A board of the level map drawn on.
- Pieces indicating the characters of each player.
- 14 movement cards, each with an arrow printed on; blank on the back side.
- Many colored dice, as the indicators of the ingredients.
- Regular dice for indicating the time limit of orders.
- A pile of order cards.

== Setup

+ Place the game board on a flat surface.
+ Place the pieces on the starting positions on the map.
+ Each player draws 7 movement cards.
+ Shuffle the order pile and place it aside.
+ Draw 3 order cards and place them by the board.
	These would be the first active orders.
	Use regular dice to keep track of their time limit.

== Game Loop

The game goes on in a loop of a sequence of stages, until the order pile is emptied and there are no active orders.

+ Drafting stage:
	Players plan their movements in this around by arranging their movement cards in arbitrary direction and order.
	There would be 7 movements for each player in a round.

+ Moving stage:
	Both players show the drafted movement sequence at the same time, and move their pieces accordingly.
	The movement goes on by steps and synchronously.
	That is, both players follow their first movement card in the sequence;
	after this is done, follow the second movement, etc.

+ Ending stage:
	- At the end of each turn, decrease every order time marker (the die) by 1.
	- If any order's required ingredients are satisfied, it is considered to be finished and could be removed from the board; the players gain the scores of that order.
	- If any order's time marker reaches 0, it is considered to be failed if it's not finished; failed orders shall be removed as well.
	- If any order is removed, refill from the pile to make sure there are always 3 active orders.
		- Unless the order pile is emptied.
		- Don't forget to place time markers on new orders.

== Interaction

There are interactive squares on the game board.
A player could interactive with them by moving onto them.
If this happens, the player's piece stays in place and the interaction takes place.

=== Ingredient basket

There are 3 kinds of basket on the map where the players could take ingredients from.
Interacting with them would cause the player to take an ingredient of the corresponding type, represented by a die with the same color, with 1 facing up.
A player could only hold 1 ingredient at a time;
if a player already holding an ingredient tries to interact with a basket, it is ignored.

=== Cooker

There are two possible cooking steps for every ingredients.
Each step corresponds to a cooking spot on the map, labelled with texts of "Cooker 1--2" and "Cooker 2--3".
After interacting with a cooker, the ingredient held by the player would change its cooked state as indicated by the cooker's name;
also, the next movement instruction of the player's would be ignored (cooking needs the player to stay in place for 1 turn).

=== Table

A player could interact with a table to place/take an ingredient on/from it.
Still, a player could carry at most one ingredient at a time.

=== Outlet

The outlet square serves as the serving table.
Players must place their cooked ingredients here to finish the order.

=== Collision

Specially, if players ever run into each other, all subsequent movement instructions are ignored for this round.

= Implementation

We simplify different ingredient into different colors and the cooking state of ingredient into numerical values.
As color is an important indicator in this game, expect colorful target items like ingredient, cookers, tables and outlet, all other elements are colorless.
The floor is white, the wall and obstacles are black, the edges of squares are gray, and the two players are white.
Moreover, only 6 basic colors are used, including red, yellow, green, orange, blue and purple, of which red, yellow and green are used to indicate ingredient related things, including ingredient ingredients and ingredient storage, orange blocks in map are table, blue blocks in map are cookers, and purple block is the outlet of ingredient delivery.
The minimalist design of the game is simple and practical to players.

== The Map

As shown in the figure below, the map includes the player activity area and the surrounding equipment placement area.
The player activity area is a $3 times 9$ checkboard with brown tables and black obstacles (@fig:map).
Players can put or pick ingredient on tables, but players cannot pass through tables or black obstacles.
Players initial place is shown in squares of Player1 born", "Player2 born".
Food storages, cookers, and delivery ports are placed around the player activity area.
There are 4 ingredient storages, where players take level 1 red, green, and yellow ingredients respectively.
There are 2 cookers, one can process level 1 ingredient to level 2 ingredient, and the other can process level 2 ingredient to level 3 ingredient.
There is also a ingredient delivery port middle-upper to the player activity area.

#figure(
	image("images/map.png", height: 2.5in),
	caption: [The map layout of the game.]
) <fig:map>

== Orders

As shown in @fig:order, the orders includes two aspects.
The left part shows the composition of the menu, and white numbers on the fan-shaped color blocks indicate the degree of cooking of the ingredient.
For example, the order below is composed of a level 3 red, a level 2 yellow, and a 3 marked green.

The right side of the menu is the score of this menu and the time limit for order completion.
For example, the order below needs to be completed within 3 turns, and the player can get 9 points after completion.

#figure(
	image("images/order.png", height: 1in),
	caption: [The illustration of an order in game.]
) <fig:order>

== Players

As shown in @fig:player, the 2 players are designed to be colorless and the marked numbers indicate Player 1 and Player 2.

#figure(
	image("images/player.png", height: 1in),
	caption: [The pieces used to represent the players.]
) <fig:player>

== Ingredient

Ingredients of different types are represented by dice of corresponding color (@fig:ingredient).
When an ingredient is picked up of the storage, it is placed with 1 point facing up.
Ingredients with 1 point facing up can be cooked by cooker 1--2, and after cooking it would be placed with 2 points facing up.
Ingredients with 2 points facing up can be cooked by cooker 2--3, and after cooking it would be placed with 3 points facing up.

#figure(
	image("images/ingredient.png", height: 0.8in),
	caption: [Dice are used to represent ingredient at different stages.]
) <fig:ingredient>

= Difficulty Model

== Identifying the Parameters

The goal of the game is to get as many scores as possible by finishing orders before the rounds run out.
This means that the scores the players get from the orders is one target parameter of the game.
Because there is little random factors throughout the game process, we state that the game's difficulty could be measured from the design of the map and the orders.

In this prototype, there are these key parameters:
- Map design: The position of each facilitation, and the distances to move between them.
- Orders: The type of the orders, the scores of each type, the time limitation of each order and the amount of the orders.
- Mechanism: The movement per round per player $M$, and the scores required to pass the level $S$.

== Moving Strategies

For each ingredient component of an order, there is theoretically a minimal movement to complete cooking it.
From this, we could estimate the minimal required movement for each order, and use that as the foundation for the numerical design of the orders.

Take the map in @fig:map as an example.
Suppose that a player starts in front of _Outlet_, to fetch the _yellow_ ingredient and cook it to level 3, the necessary movement could be:
#math.equation(block: true, numbering: none)[$
	#hide[0 +] & 3 (text("Get ingredient")) \
	#hide[0] + & 6 (text("To cooker 1-2")) + 1 (text("Cook")) \
	#hide[0] + & 3 (text("To cooker 2-3")) + 1 (text("Cook")) \
	#hide[0] + & 3 (text("To outlet")) + 1 (text("Serve")) \
	#hide[0] = & 18.
$]
Similarly, we could calculate the estimated minimal movement for any orders.

However, considering that the main aesthetic of the game is the cooperation between players, we think that it is mainly reflected on two points:

+ Use the _table_ block provided in the game to pass the ingredients and avoid unnecessary movement.
+ Avoid running into each other while moving as it leads to waste of movement.

Therefore it is also necessary to calculate the minimal movement when the _table_ blocks are used:

#block(
	breakable: false,
	grid(
		columns: (1fr, 1fr),
		align: (center, center),
		row-gutter: 1em,
		[Player 1],
		[Player 2],
		math.equation(block: true, numbering: none)[$
			#hide[0 +] & 3 (text("Get ingredient")) \
			#hide[0] + & 1 (text("Place on table")) \
			#hide[0] + & 4 (text("Take and serve the cooked ingredient")) \
			#hide[0] = & 8.
		$],
		math.equation(block: true, numbering: none)[$
			#hide[0 +] & 1 (text("Take ingredient from table")) \
			#hide[0] + & 2 (text("To cooker 1-2")) + 1 (text("Cook")) \
			#hide[0] + & 3 (text("To cooker 2-3")) + 1 (text("Cook")) \
			#hide[0] + & 4 (text("Place the cooked ingredient on table")) \
			#hide[0] = & 12.
		$],
	)
)

Speaking from the numbers, when not using table, every player could finish cooking a level-3 ingredient within a minimal movement of 18; but when using table, the number would increase to 20.
Albeit not precise, it seems like the overall effectiveness would be higher if the players choose not to use the table.

But this is not the reality.
As said previously, there is punishment for collisions in out game:
Whenever players are moving into the same square, they would dizzle due to crashing into each other, causing the movement to fail and all remaining actions for this turn to be lost.
Because it is hard to predict players' actions, we assume that the probability of the occurrence per round per action is constant;
then the loss of movement per collision could be given as @eq:mov-loss-per-collision.

#math.equation(block: true)[$
	2 times ((M-1)/2+1).
$] <eq:mov-loss-per-collision>

In our current design, $M=7$;
so the loss of movement per collision would be $2 times ((7-1)/2+1)=8$.

It now can be seen that as long as collision happens, the expected total movement for cooking one ingredient with a non-cooperative strategy would be higher than a cooperative strategy, because in cooperative plays there is no chance for the players to collide.
The three squares on the middle axis of th map would be passed by the players the most frequently, also the order of using the cookers is fixed, so the chance of a collision happening is significantly high.

It is certainly possible to use other strategies than cooperation to avoid collisions.
For example, one player could always use the outer route to go to the cooker, so that it would take 4 more movements to cook an ingredient than the optimal route, resulting in the same overall performance with a cooperative strategy;
but this strategy also cannot avoid collisions completely, as there is only one cooker of each kind on the map, and it will take one around to do the cooking.
The players themselves would become the blockades on the path.

== Level Difficulty

Here we will discuss in detail about another non-intuitive yet key parameter:
The minimal required movement to prepare all ingredients in an order.
We hope that the score of each order could proportionally match their minimal movement to avoid the imbalance between different kinds of order.
We established a standard ratio $Q$ of the score to the expected movement of an order, and managed to make sure that this statistic of all orders' are close to $Q$ (they don't have to be exactly equal).

The prototype mainly tests the cooperation level between the players and their ability to plan the moving routes.
Either insufficient cooperation, adapting a non-optimal strategy and colliding with other players would lead to waste of movement compared to the optimal strategy.
To help understand, we have the following formulae:

#grid(
	columns: (1fr, 1fr),
	math.equation(block: true, numbering: none)[$
		& #hide($0 -$) \#(text("actual movement to win")) \
		& #hide($0$) - \#(text("theoretical minimum movement")) \
		& #hide($0$) = \#(text("movement wasted")),
	$],
	math.equation(block: true, numbering: none)[$
		& #hide($0 -$) \#(text("total available movement")) \
		& #hide($0$) - \#(text("theoretical minimum movement")) \
		& #hide($0$) = \#(text("movement that could be wasted")).
	$],
)

When the movement wasted is more than the movement that could be wasted, the rest available movement could be less than the movement required to win the game, meaning that the players would likely lose the game.
The closer the theoretical minimum movement to the total available movement, the more difficult it is for the player to win the game.
We define the level difficulty to be the ratio of these two: (@eq:level-dificulty)

#math.equation(block: true)[$
	D = \#(text("theoretical minimum movement")) / \#(text("total available movement")).
$] <eq:level-dificulty>

By investigating the order pile, some parameters could be estimated.
Until the order pile is emptied, there are always 3 active orders, which means that the order timer would decrease by 3 each round.
Then the total available movement could be estimated as @eq:total-available-movement.

#math.equation(block: true)[$
	(text("total available movement")) =
	1/3 sum_text("order pile") (text("order time")) times M times 2 (text("#player")).
$] <eq:total-available-movement>

Also, the theoretical minimum movement is given by @eq:theoretical-minimum-movement.

#math.equation(block: true)[$
	(text("theoretical min. movement")) =
	((text("required score to win"))) / Q.
$] <eq:theoretical-minimum-movement>

When a level design is finished, the expected movement for finishing each order is then decided.
By adjusting the amount and the type of the orders in the pile, and their score and time limitation, we could adjust the players' total available movement freely, as well as the theoretical minimum movement required by the level.
This means that only by adjusting the order pile and the level passing score, we could control the level difficulty.

== Adjusting

We hope that in the first level, $Q=60%$, while in the second level $Q=78%$.
Numerically, this meets the expectation that the second level would be 30% harder than the first level;
but it still remains a question whether this is what the players would feel about the difficulty, which needs to be find out by further playtesting.

Below are the numerical analysis of this map.

=== Individually Optimal Strategy

Let's assume that there is only one player who spawns below the _Outlet_ square and returns to the same square after each order is made.
The expected movement for cooking each type of ingredient would be given as @table:individually-optimal-strategy.

#figure(
	caption: [The expected movement for cooking ingredients in the IO strategy.],
	table(
		columns: (auto, auto),
		align: (center, center),
		table.hline(),
		table.header([Type], [Movement]),
		table.hline(stroke: 0.5pt),
		[Yellow2], [13],
		[Yellow3], [17],
		[Red2],		 [12],
		[Red3],		 [16],
		[Green2],	 [12],
		[Green3],	 [16],
		table.hline(),
	),
) <table:individually-optimal-strategy>

Back to the two-player case, we let the expectation of the amount of collision occurrence within one cooking proccess be $K_1$.

=== Longer Route Strategy

In this strategy, to avoid collision, one player would take longer routes by the rim of the map, but still returns to the origin from the middle passageway after cooking.
Then the expected movement for each ingredient would be given as @table:longer-role-strategy.

#figure(
	caption: [The expected movement for cooking ingredients in the LR strategy.],
	table(
		columns: (auto, auto),
		align: (center, center),
		table.hline(),
		table.header([Type], [Movement]),
		table.hline(stroke: 0.5pt),
		[Yellow2], [16],
		[Yellow3], [20],
		[Red2],		 [16],
		[Red3],		 [20],
		[Green2],	 [18],
		[Green3],	 [22],
		table.hline(),
	),
) <table:longer-role-strategy>

We also let $K_2$ be the same expectation of collision under this strategy.

=== Cooperative Strategy

In this strategy, one player always stays in the upper half of the board, passes ingredients to the tables, and take cooked ingredients from the table and serve them;
the other player always stays in the lower half of the board and cook the passed ingredients.
The expectation table would be @table:cooperative-strategy.

#figure(
	caption: [The expected movement for cooking ingredients in the cooperative strategy.],
	table(
		columns: (auto, auto, auto),
		align: (center, center, center),
		table.hline(),
		table.header([Type], [Player 1], [Player 2]),
		table.hline(stroke: 0.5pt),
		[Yellow2], [8], [6],
		[Yellow3], [8], [12],
		[Red2],		 [8], [6],
		[Red3],		 [8], [12],
		[Green2],	 [8], [6],
		[Green3],	 [8], [12],
		table.hline(),
	),
) <table:cooperative-strategy>

Considering the $K$ values, the overall table comparing all strategies is shown in @table:all-strategies.

#figure(
	caption: [Comparison between all strategies.],
	table(
		columns: (auto, auto, auto, auto),
		align: (center, center, center, center),
		table.hline(),
		table.header([Type], [IO], [LR], [Cooperative]),
		table.hline(stroke: 0.5pt),
		[Yellow2], [$13+4K_1$], [$(16+13)slash 2+4K_2=14.5+4K_2$], [$14$],
		[Yellow3], [$17+4K_1$], [$(20+17)slash 2+4K_2=18.5+4K_2$], [$20$],
		[Red2],		 [$12+4K_1$], [$(16+12)slash 2+4K_2=14.0+4K_2$], [$14$],
		[Red3],		 [$16+4K_1$], [$(16+20)slash 2+4K_2=18.0+4K_2$], [$20$],
		[Green2],	 [$12+4K_1$], [$(12+18)slash 2+4K_2=15.0+4K_2$], [$14$],
		[Green3],	 [$16+4K_1$], [$(22+16)slash 2+4K_2=19.0+4K_2$], [$20$],
		table.hline(),
	)
) <table:all-strategies>

We can see from the data that, theoretically speaking, regardless of the type of the ingredients, as long as there happens just one collision, the cooperative strategy will become the optimal approach.
Via physical testing of the moving strategy, we found that the non-cooperative strategies would cause great waste of movement and waitings.
They are most ineffective compared to the cooperative strategy.
Based on this, we set the expected movement data under the cooperative strategy to be the standard expection.

=== Orders

We have designed the following orders as shown in @table:orders ($Q=1 slash 6$).

#figure(
	caption: [Order designs.],
	table(
		columns: (auto, auto, auto, auto),
		align: (center, center, center, center),
		table.hline(),
		table.header([Ingredients], [Movement], [Scores], [Time limit]),
		table.hline(stroke: 0.5pt),
		[Yellow2 + Red2 + Green2], [42], [ 7], [3],
		[Yellow2 + Red3 + Green3], [54], [ 9], [4],
		[Yellow3 + Red3 + Green3], [60], [10], [5],
		table.hline(),
	)
) <table:orders>

Let there be 5 of each type of order in the pile, then the total number of turns would be $5 times (3+4+5) slash 3 = 20$.
When $M=7$, the total movememnt would be $2 times 20 times 7 = 280$ steps.

To match the difficulty of level 1, the expected movement should be $60% times 280 = 168$ steps.
Given that $Q = 1 slash 6$, the required score to pass level 1 should be $168 times 1 slash 6 = 28$.

If the order pile is not changed, then to match the difficulty of level 2, the required passing score should be $280 times 78% times 1 slash 6 = 36.4$, rounded down to $36$.

#show heading.where(level: 2): set heading(numbering: none);
#show heading.where(level: 3): set heading(numbering: none);

= Playtest and Feedback

We went through multiple rounds of testing and feedback to adjust our mechanics and balancing.
In the initial version, many mechanics and content were quite different from the final version:

+ In the initial version, the spawn points of the two players were placed in the center of the map, and the players would be moved back to the spawn point after a crash.
+ Each player's hand used to consist of 4 movement cards and 1 interact card.
	To interact with a special grid, you need to use an interact card, and movement cannot cause interaction.
+ Processing food did not consume just one extra movement, but consumed all remaining movements in this turn.
+ The initial map size is smaller than the final map.
+ The order must be completed when the ingredients are submitted, rather than when the timers become zero.

#heading(level: 2, numbering: none)[Playtest 1.1---Developer Testing]

=== Feedback

Almost as soon as the game started, we found that when players were spawn at the center of the game, they would have a huge chance of getting into serious conflicts right from the beginning.

=== Solution

We immediately changed the players' spawn points to the two ends of the map to avoid continuous conflicts at the beginning of the game that would make the game unplayable (@fig:playtest-map).

#figure(
	caption: [The updated version of the map after playtesting.],
	image("images/playtest-map.png", height: 12em),
) <fig:playtest-map>

#heading(level: 2, numbering: none)[Playtest 1.2---Developer Testing]

=== Feedback

We played a few times. Since we had a good understanding of how the game works, we decided to restrict ourselves to no communication when playing with two people. This restriction caused our movements to conflict a few times, causing our pieces to return to their spawn points. We realized that this penalty was too severe for players, not only wasting actions in the current turn, but also disrupting all planning that players had done before.

=== Solution

We decided to change the rules so that when a conflict occurs, players will stay in their positions before the conflict and end their turn. Players can keep their progress in executing their plans and think about how to avoid future conflicts in the same place.

=== Result

After two revisions, our game became playable, and there were no more frustrations and difficulties in testing that went against the designers' intentions.

#heading(level: 2, numbering: none)[Playtest 2---Developer Testing]

=== Feedback

After we completed the initial order design, we tried to set a target score according to our mathematical model and played several games. We found that the game seemed to be more difficult than expected and did not provide the expected error tolerance for players. The game usually ended two to three rounds earlier than we expected, which resulted in a higher difficulty than we estimated.

=== Solution

After analysis, we found that according to the original order completion rules, some orders were completed when there was still a lot of time left, causing new orders to fill the gap immediately. In general, the early completion of orders caused the order deck to be consumed faster, and also led to a reduction in the number of game rounds, which is difficult to calculate and estimate. We decided to change the order completion rules so that active orders are checked for completion when the countdown reaches 0. After this change, the number of game rounds became in line with our expectations, and the game rounds were only slightly extended when there were one or two orders left at the end, which was what we expected.

=== Results

We found an oversight in our mathematical model. Since it is difficult to estimate the total number of game rounds while taking into account the problem of completing orders, we chose to change the game rules to match our mathematical model without affecting the aesthetic and dynamics of the game.

#heading(level: 2, numbering: none)[Playtest 3---Player Testing]

=== Feedback

The feedback from our player testing focused on the pace of the game. Players generally felt that the number of rounds in the game was limited, and that only a limited amount of things could be done in each round. Players particularly disliked using specific interact cards to interact with special grids, as this greatly limited what they could do in each round. Players also disliked that processing ingredients would skip an entire round, which led to a lot of time wasted and time bottlenecks in the processing stage when working together.

=== Solution

After careful consideration, we cancelled the design of interact cards and made all interactions triggered by movement. We increased the number of movements per round (4>7) to expand the player's decision-making space and action capabilities. We also changed the extra time consumed on processing ingredients from the entire current turn to the next movement of the current turn. Players can still avoid this effect through clever planning, but now players can do more things after processing and plan their actions more freely.

=== Results

We optimized the game mechanics based on player experience, and redesigned the order decks and target scores based on our mathematical model.

#heading(level: 2, numbering: none)[Playtest 4]

=== Feedback

We found a minor issue where players tended to move from the outer channel rather than the middle channel when picking up and processing yellow ingredients. When we asked them why, they replied that the distance from the left yellow ingredient to the processing table below was the same from both sides, and that taking the middle channel was more likely to cause conflict. In our concept design, the middle channel should be a high-risk-high-reward option, while the outer channel should be a low-risk-low-reward option, providing players with two meaningful choices. This reflects the mismatch between our concept design and the actual map design.

=== Solution

After thinking about it, we finally decided to widen the map horizontally by two squares, making the outer channel slightly longer than the middle channel. Not only from a numerical point of view, but also from an intuitive point of view, the middle channel is more attractive than before, which also fits our map design concept. Then, based on the new map, we designed a new order deck and score target according to the mathematical model.

=== Result

We corrected the mistakes in map design, and judging from the results of mathematical models and playtest, the current balance of the game is satisfactory.

= Acknowledgement

Special thanks to _Yichi_'s roommate and our great classmate, _Zhuowen Song_ (宋卓文)'s generous effort on playtesting the game.