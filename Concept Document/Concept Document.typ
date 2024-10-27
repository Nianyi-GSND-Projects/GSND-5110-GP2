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
我写。
*得等柴哥写完上一段。*

= Difficulty Model

把亦驰写过的翻译、整合进来即可。

= Physical Implementation

物理实现，以及（视觉）美学设计。
严姐写？

= Playtest and Feedback

测试反馈结果。
亦驰写。