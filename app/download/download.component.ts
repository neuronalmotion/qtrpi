import { Component } from '@angular/core';

@Component({
	moduleId: module.id,
	selector: "download",
	template: `<h1>{{title}}</h1>`
})

export class DownloadComponent {
	title = 'Download...';
}