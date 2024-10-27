// Preambles

#set page(paper: "us-letter", margin: 1in)
#set par(justify: true)
#show text.where(lang: "zh"): set text(font: "KaiTi")
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
#show math.equation.where(block: true): set math.equation(numbering: "1");

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
				ilink("https://trello.com/invite/b/6701e44779ec640c5d328f0e/ATTI2e4e5c2ac806f734622a4564c54e84232C3A9BAB/group-project-2-prototyping-and-balancing")[Trello Board],
				ilink("https://github.com/Nianyi-GSND-Projects/GSND-5110-GP2/blob/master/Team%20Log/Team%20Log.md")[Team Log],
			)
		);
	}
})[
	Concept Document for _Overcooked!_ Tabletop
][
	Group Project \#2 for GSND 5110, Group \#6
];

= Group Members

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

= Overview

先简要介绍原始游戏和改编版本的概况。
我写。

= Original Game Dissection

剖析原始游戏之“essense”。
把第一周时我写的那一坨粘进来即可。

= Mechanism Design

承继上节，介绍我们是如何将那些essense改编成桌游机制的。
柴哥写。

= MDA Analysis

将上节总结成表。
亦驰写。

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

#figure(
	image("images/map.png", height: 2.5in),
	caption: [The map layout of the game.]
) <fig:map>

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

= Implementation

We simplify different food into different colors and the cooking state of food into numerical values.
As color is an important indicator in this game, expect colorful target items like food, cookers, tables and outlet, all other elements are colorless.
The floor is white, the wall and obstacles are black, the edges of squares are gray, and the two players are white.
Moreover, only 6 basic colors are used, including red, yellow, green, orange, blue and purple, of which red, yellow and green are used to indicate food related things, including food ingredients and food storage, orange blocks in map are table, blue blocks in map are cookers, and purple block is the outlet of food delivery.
The minimalist design of the game is simple and practical to players.

== The Map

As shown in the figure below, the map includes the player activity area and the surrounding equipment placement area.
The player activity area is a $3 times 9$ checkboard with brown tables and black obstacles (@fig:map).
Players can put or pick food on tables, but players cannot pass through tables or black obstacles.
Players initial place is shown in squares of Player1 born", "Player2 born".
Food storages, cookers, and delivery ports are placed around the player activity area.
There are 4 food storages, where players take level 1 red, green, and yellow ingredients respectively.
There are 2 cookers, one can process level 1 food to level 2 food, and the other can process level 2 food to level 3 food.
There is also a food delivery port middle-upper to the player activity area.

== Orders

As shown in @fig:order, the orders includes two aspects.
The left part shows the composition of the menu, and white numbers on the fan-shaped color blocks indicate the degree of cooking of the food.
For example, the order below is composed of a level 3 red, a level 2 yellow, and a 3 marked green.

The right side of the menu is the score of this menu and the time limit for order completion.
For example, the order below needs to be completed within 3 turns, and the player can get 9 points after completion.

#figure(
	image("images/order.png", height: 1.5in),
	caption: [The illustration of an order in game.]
) <fig:order>

== Players

As shown in @fig:player, the 2 players are designed to be colorless and the marked numbers indicate Player 1 and Player 2.

#figure(
	image("images/player.png", height: 1.5in),
	caption: [The pieces used to represent the players.]
) <fig:player>

== Food

Different colored food is represented by dice of corresponding color (@fig:food).
When food is picked up of the storage, it is placed with 1 point facing up.
Food with 1 point facing up can be cooked by cooker 1--2, and after cooking it would be placed with 2 points facing up.
Food with 2 points facing up can be cooked by cooker 2--3, and after cooking it would be placed with 3 points facing up.

#figure(
	image("images/food.png", height: 0.8in),
	caption: [Dice are used to represent food at different stages.]
) <fig:food>

= Playtest and Feedback

测试反馈结果。
亦驰写。

= Acknowledgement

Special thanks to _Yichi_'s roommate and our great classmate, _Zhuowen Song_ (宋卓文)'s generous effort on playtesting the game.