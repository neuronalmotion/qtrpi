import { Component } from '@angular/core';

@Component({
	moduleId: module.id,
	selector: "home",
	template: `<h1>{{title}}</h1>`
})

export class HomeComponent {
	title = 'Home sweet home';
}