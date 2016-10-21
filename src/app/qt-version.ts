export class QtVersion {
    versionName: string;
    binaries: QtBinary[];
}

export class QtBinary {
    module: string;
    description: string;
    urlRPi1: string;
    urlRPi2: string;
    urlRPi3: string;
}

