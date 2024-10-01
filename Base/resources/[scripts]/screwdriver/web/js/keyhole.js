const lockOpenSound = new Audio("./assets/audio/openlocksong.mp3");
lockOpenSound.volume = 0.2;

class Keyhole {
  #rotateStep;
  #restoreStep;
  #lockTurnWay;

  static wrongRotateEvent = new CEvent();
  static lockOpenEvent = new CEvent();

  constructor(
    domElement,
    latch,
    rotateStep = 0.75,
    restoreStep = 2.35,
  ) {
    this.domElement = domElement;
    this.latch = latch;

    this.#rotateStep = rotateStep;
    this.#restoreStep = restoreStep;
    this.#lockTurnWay = Math.sign(randomInteger(-90, 90)); // -1: left, 1: right

    this.rotation = 0;
  }

  animate() {
    if (this.domElement) {
      this.domElement.style.transform = "rotateZ(" + this.rotation + "deg)";
    }
  }

  rotate() {
    if (!pressedKey) {
      this.rotation -= Math.sign(this.rotation) * this.#restoreStep;
      if (Math.abs(this.rotation) < this.#restoreStep - 0.001) {
        this.rotation = 0;
      }
      return;
    }

    const key = pressedKey;
    if (key == 68) { // D
      this.rotation += this.#rotateStep;
      this.rotation = Math.min(90, this.rotation + this.#rotateStep);
    }

    if (key == 65) { // A
      this.rotation -= this.#rotateStep;
      this.rotation = Math.max(-90, this.rotation - this.#rotateStep);
    }

    if (this.#lockTurnWay != Math.sign(this.rotation) && Math.abs(this.rotation) > 15) {
      Keyhole.wrongRotateEvent.invoke(this);
      return;
    }

    if (!this.latch.defused) {
      Keyhole.wrongRotateEvent.invoke(this);
    } else {
      this.#tryOpenLock();
    }
  }

  #tryOpenLock() {
    if (Math.sign(this.rotation) != Math.sign(this.#lockTurnWay)) {
      return;
    }

    const absRotate = Math.abs(this.rotation);

    if (absRotate >= 90 - 0.001) {
      this.#openLock();
    }
  }

  #openLock() {
    playOpenlockSound();
    Keyhole.lockOpenEvent.invoke(this);
  }
}

lockOpenSound.onended = (event) => {
  lockOpenSound.currentTime = 0;
}

function playOpenlockSound() {
  if (lockOpenSound.currentTime != 0) {
    return;
  }

  lockOpenSound.currentTime = 0.2;
  lockOpenSound.play();
}