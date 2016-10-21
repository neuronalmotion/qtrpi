import { Component } from '@angular/core';
import { NavigationEnd, Router }   from '@angular/router';

import "rxjs/add/operator/distinctUntilChanged"

// Declare ga function as ambient
declare var ga: any;

@Component({
    selector: 'app',
    templateUrl: './app.component.html'
})

export class AppComponent {
    constructor(public router: Router) {
        router.events.distinctUntilChanged((previous: any, current: any) => {
            if(current instanceof NavigationEnd) {
                return previous.url === current.url;
            }
            return true;
        }).subscribe((x: any) => {
            console.log('router.change', x);
            ga('send', 'pageview', x.url);
        });
    }
}

