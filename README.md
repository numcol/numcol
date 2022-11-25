# NumCol

The Brain Training Game About Matching Numbers And Colours.

[![Build Status](https://api.cirrus-ci.com/github/numcol/numcol.svg)](https://cirrus-ci.com/github/numcol/numcol)
[![AUR](https://img.shields.io/aur/license/yaourt.svg)](LICENSE)
[![Coverage Status](https://coveralls.io/repos/github/numcol/numcol/badge.svg?branch=master)](https://coveralls.io/github/numcol/numcol?branch=master)

This repo contains the source code of the latest versions of the [NumCol][0] Android Game.

## Get Started

### Pre-requisites

- [Flutter][1]

For help getting started with Flutter, view the online
[documentation][1].

### Installation

```sh
git clone https://github.com/numcol/numcol.git
cd numcol
```

### Run project locally

```sh
flutter run
```

Or use VSCode/Itenllij to debug.

### Test

```sh
flutter test .
```

### Release

```sh
# Ensure key info is stored in android/key.properties
flutter build apk --release
# Install on device
flutter install
```

### Deploy

Pre-requisites:

- [Fastlane][2]

```sh
# Ensure google play api service credentials are stored in fastlane-playstore.json
fastlane beta
```

## License

NumCol - The Brain Training Game About Matching Numbers And Colours.  
Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <https://www.gnu.org/licenses/>.

## Fonts Licensing

Fonts are not authored by Alberto Varela and they are authored and licensed as described below:

### Fredoka

Copyright 2016 The Fredoka Project Authors (<https://github.com/hafontia/Fredoka-One>)

License: [SIL OPEN FONT LICENSE Version 1.1 - 26 February 2007](https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL)

### Poired One

Copyright (c) 2011, Denis Masharov (denis.masharov@gmail.com)

License: [SIL OPEN FONT LICENSE Version 1.1 - 26 February 2007](https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL)

### Raleway

Copyright (c) 2010, Matt McInerney (matt@pixelspread.com),  
Copyright (c) 2011, Pablo Impallari (www.impallari.com|impallari@gmail.com),  
Copyright (c) 2011, Rodrigo Fuenzalida (www.rfuenzalida.com|hello@rfuenzalida.com), with Reserved Font Name Raleway

License: [SIL Open Font License](https://www.fontsquirrel.com/license/raleway)

### Lemon Milk

Copyright (c) 2014-2018, MARSNEV (marsnev@marsnev.com)

License: [Donationware](https://blog.marsnev.com/p/faq.html)

### Roboto Mono

Copyright (c) 2015, Google Inc.

License: [Apache License](https://github.com/google/fonts/blob/master/apache/robotomono/LICENSE.txt)

[0]: https://play.google.com/store/apps/details?id=com.numcol.free
[1]: https://flutter.io/
[2]: https://docs.fastlane.tools/
