let pressedKey = null;
let cooldown = null;
let controlsFreeze = false;
let m_lockpick = null;

freezeControls();

window.onload = () => {
  unFreezeControls();
  fps.start();
  document.body.style.display = "none";
}

Keyhole.wrongRotateEvent.on = disablePressedKey;
Keyhole.lockOpenEvent.on = stopAnimate;
Keyhole.lockOpenEvent.on = freezeControls;
Keyhole.lockOpenEvent.on = (keyhole) => {
  reward()
}

Lockpick.breakEvent.on = freezeControls;
Lockpick.breakEvent.on = (lockpick) => {
  penalty()
}
Lockpick.createdEvent.on = (lockpick) => {
  m_lockpick = lockpick;
  unFreezeControls();
}

const m_latch = new Latch();
const m_keyhole = new Keyhole(keyhole_img, m_latch);
createLockpick();

const fps = new FpsControl(30, (e) => {
  m_keyhole?.rotate();
  m_keyhole?.animate();
  m_lockpick?.animate();
});

Lockpick.createdEvent.on = () => fps.start();

window.addEventListener("keydown", (evt) => {
  if (controlsFreeze) {
    return;
  }

  if ([68, 65].includes(evt.keyCode) && !cooldown) {
    pressedKey = evt.keyCode;
  } else {
    pressedKey = null;
  }
})

window.addEventListener("keyup", (evt) => {
  if (controlsFreeze) {
    return;
  }

  pressedKey = null;
})

window.addEventListener("mousemove", (evt) => {
  if (controlsFreeze) {
    return;
  }

  m_lockpick?.rotate(evt);
})

function stopAnimate() {
  fps.pause();
}

function disablePressedKey() {
  pressedKey = null;
  startCooldown();
}

function freezeControls() {
  controlsFreeze = true;
}

function unFreezeControls() {
  controlsFreeze = false;
}

function startCooldown() {
  if (cooldown) {
    return;
  }

  cooldown = setTimeout(() => {
    clearTimeout(cooldown);
    cooldown = null;
  }, 100);
}

function createLockpick() {
  if (!lockpick_img || !(lockpick_img instanceof HTMLImageElement)) {
    throw "LockpickDom is null"
  }

  if (!m_keyhole || !(m_keyhole instanceof Keyhole)) {
    throw "Keyhole is null";
  }

  if (m_lockpick && m_lockpick instanceof Lockpick) {
    m_lockpick.dispose();
  }

  new Lockpick(lockpick_img, m_keyhole);
}

window.addEventListener('message', function(event) {
	var item = event.data;
	if (item.showUI) {
		document.body.style.display = 'block'
      document.getElementById('text1').innerHTML = item.text1;
      document.getElementById('text2').innerHTML = item.text2;
      document.getElementById('text3').innerHTML = item.text3;
	} else {
		document.body.style.display = 'none'
	}
});

document.onkeyup = function (data){
	if (data.which == 27) {
    exit()
	}
};

function exit() {
    $.post(
      "https://screwdriver/Exit",
      JSON.stringify({})
    );
    document.location.reload();
    return;
  }

function penalty() {
  $.post(
      "https://screwdriver/Fail",
      JSON.stringify({})
  );

  exit()
}

function reward() {
  $.post(
      "https://screwdriver/Done",
      JSON.stringify({})
  );

  exit()
}

window.onerror = function() {
	return true;
};