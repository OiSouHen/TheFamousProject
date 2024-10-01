class Latch {
  constructor(minRotate = -50, maxRotate = 110) {
    this.minRotate = minRotate;
    this.maxRotate = maxRotate;

    this.trueRotation = randomInteger(this.minRotate, this.maxRotate);
    this.defused = false;
  }

  restore() {
    this.defused = false;
  }

  takeOff() {
    this.defused = true;
  }

  hasTrueRotation(rotation) {
    const eps = 0.001;

    const inaccuracy = 5 + eps;
    return Math.abs(rotation - this.trueRotation) < inaccuracy;
  }
}