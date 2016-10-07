import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';

import { AppComponent }  from './app/app.component';
import { HomeComponent } from './home/home.component';
import { DownloadComponent } from './download/download.component';

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
			path: 'download',
			component: DownloadComponent
		}
    ])
  ],
  
  declarations: [ 
  	AppComponent,
  	HomeComponent,
  	DownloadComponent
  ],

  bootstrap: [ AppComponent ]
})


export class AppModule { }
