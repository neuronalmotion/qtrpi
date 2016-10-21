import { Component, OnInit } from '@angular/core';
import { QtVersion } from '../qt-version';

@Component({
    selector: 'app-download-qt',
    templateUrl: './download-qt.component.html'
})
export class DownloadQtComponent implements OnInit {

    qtVersions: QtVersion[] = [
        {
            versionName: '5.7.1',
            binaries: [
                {
                    module: 'QtCore',
                    description: 'QtBase, etc...',
                    urlRPi1: '/download/1',
                    urlRPi2: '/download/2',
                    urlRPi3: '/download/3'
                },
                {
                    module: 'Qt3D',
                    description: 'qt3d....',
                    urlRPi1: '/download/1',
                    urlRPi2: '/download/2',
                    urlRPi3: '/download/3'
                }
            ]
        },
        {
            versionName: '5.6.2',
            binaries: [
                {
                    module: 'QtCore',
                    description: 'QtBase, etc...',
                    urlRPi1: '/download/1',
                    urlRPi2: '/download/2',
                    urlRPi3: '/download/3'
                },
                {
                    module: 'Qt3D',
                    description: 'qt3d....',
                    urlRPi1: '/download/1',
                    urlRPi2: '/download/2',
                    urlRPi3: '/download/3'
                }
            ]
        },
        {
            versionName: '5.5.1',
            binaries: [
                {
                    module: 'QtCore',
                    description: 'QtBase, etc...',
                    urlRPi1: '/download/1',
                    urlRPi2: '/download/2',
                    urlRPi3: '/download/3'
                },
                {
                    module: 'Qt3D',
                    description: 'qt3d....',
                    urlRPi1: '/download/1',
                    urlRPi2: '/download/2',
                    urlRPi3: '/download/3'
                }
            ]
        }
    ]

    ngOnInit() {
    }

}
