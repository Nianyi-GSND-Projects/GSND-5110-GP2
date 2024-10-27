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

把亦驰写过的翻译、整合进来即可。

= Implementation

We simplify different food into different colors and the cooking state of food into numerical values.
As color is an important indicator in this game, expect colorful target items like food, cookers, tables and outlet, all other elements are colorless.
The floor is white, the wall and obstacles are black, the edges of tiles are gray, and the two players are white.
Moreover, only 6 basic colors are used, including red, yellow, green, orange, blue and purple, of which red, yellow and green are used to indicate food related things, including food ingredients and food storage, orange blocks in map are table, blue blocks in map are cookers, and purple block is the outlet of food delivery.
The minimalist design of the game is simple and practical to players.

== The Map

As shown in the figure below, the map includes the player activity area and the surrounding equipment placement area.
The player activity area is a $3*9$ tile map with brown tables and black obstacles (@fig:map).
Players can put or pick food on tables, but players cannot pass through tables or black obstacles.
Players initial place is shown in tiles of "Player1 born", "Player2 born".
Food storages, cookers, and delivery ports are placed around the player activity area.
There are 4 food storages, where players take 1-marked red, green, and yellow ingredients respectively.
There are 2 cookers, one can process 1-marked food to 2-marked food, and the other can process 2-marked food to 3-marked food.
There is also a food delivery port middle-upper to the player activity area.

#figure(
	image("images/map.png", height: 2.5in),
	caption: [The map layout of the game.]
) <fig:map>

== Orders

As shown in @fig:order, the orders includes two aspects.
The left part shows the composition of the menu, and white numbers on the fan-shaped color blocks indicate the degree of cooking of the food.
For example, the order below is composed of a 3-marked red, a 2-marked yellow, and a 3 marked green.

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