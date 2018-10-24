// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

abstract class TimerContract {
  int get elapsedInMilliseconds;
  int get maxTimeInMilliseconds;
  Stream get gameoverStream;
  void start(int maxTimeInMilliseconds);
  void stop();
}
