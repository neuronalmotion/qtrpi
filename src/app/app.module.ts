import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';

import { AppComponent }  from './app.component';
import { HomeComponent } from './home/home.component';
import { DownloadComponent } from './download/download.component';
import { FaqComponent } from './faq/faq.component';
import { DownloadQtComponent } from './download-qt/download-qt.component';

@NgModule({
  imports: [
    BrowserModule,
    FormsModule,
    RouterModule.forRoot([
	    {
	    	path: '',
	    	redirectTo: '/home',
	    	pathMatch: 'full'
	    },
		{
			path: 'home',
			component: HomeComponent
		},
		{
			path: 'faq',
			component: FaqComponent
		},
		{
			path: 'download',
			component: DownloadComponent
		}
    ])
  ],

  declarations: [
  	AppComponent,
  	HomeComponent,
  	DownloadComponent,
  	FaqComponent,
  	DownloadQtComponent
  ],

  bootstrap: [ AppComponent ]
})


export class AppModule { }
