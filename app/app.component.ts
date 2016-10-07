import { Component } from '@angular/core';

@Component({
	moduleId: module.id,
	selector: "app",
	template: `<h1>{{title}}</h1>
	 			<nav>
	 				<a routerLink="/home" routerLinkActive="active">Home</a>
	 				<a routerLink="/download" routerLinkActive="active">Download</a>
	 			</nav>
	 			<router-outlet></router-outlet>`
})

export class AppComponent {
	title = 'Qt Raspberry Pi binaries';
}