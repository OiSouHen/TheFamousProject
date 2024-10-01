const ah = function () {
  const t = document.createElement("link").relList;
  if (t && t.supports && t.supports("modulepreload")) return;
  for (const i of document.querySelectorAll('link[rel="modulepreload"]')) r(i);
  new MutationObserver((i) => {
    for (const o of i)
      if (o.type === "childList")
        for (const l of o.addedNodes)
          l.tagName === "LINK" && l.rel === "modulepreload" && r(l);
  }).observe(document, { childList: !0, subtree: !0 });
  function n(i) {
    const o = {};
    return (
      i.integrity && (o.integrity = i.integrity),
      i.referrerpolicy && (o.referrerPolicy = i.referrerpolicy),
      i.crossorigin === "use-credentials"
        ? (o.credentials = "include")
        : i.crossorigin === "anonymous"
        ? (o.credentials = "omit")
        : (o.credentials = "same-origin"),
      o
    );
  }
  function r(i) {
    if (i.ep) return;
    i.ep = !0;
    const o = n(i);
    fetch(i.href, o);
  }
};
ah();
var Yc = { exports: {} },
  rt = {},
  A = { exports: {} },
  J = {};
/**
 * @license React
 * react.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */ var si = Symbol.for("react.element"),
  uh = Symbol.for("react.portal"),
  ch = Symbol.for("react.fragment"),
  fh = Symbol.for("react.strict_mode"),
  dh = Symbol.for("react.profiler"),
  ph = Symbol.for("react.provider"),
  hh = Symbol.for("react.context"),
  mh = Symbol.for("react.forward_ref"),
  vh = Symbol.for("react.suspense"),
  gh = Symbol.for("react.memo"),
  yh = Symbol.for("react.lazy"),
  su = Symbol.iterator;
function Sh(e) {
  return e === null || typeof e != "object"
    ? null
    : ((e = (su && e[su]) || e["@@iterator"]),
      typeof e == "function" ? e : null);
}
var Xc = {
    isMounted: function () {
      return !1;
    },
    enqueueForceUpdate: function () {},
    enqueueReplaceState: function () {},
    enqueueSetState: function () {},
  },
  Qc = Object.assign,
  Kc = {};
function ur(e, t, n) {
  (this.props = e),
    (this.context = t),
    (this.refs = Kc),
    (this.updater = n || Xc);
}
ur.prototype.isReactComponent = {};
ur.prototype.setState = function (e, t) {
  if (typeof e != "object" && typeof e != "function" && e != null)
    throw Error(
      "setState(...): takes an object of state variables to update or a function which returns an object of state variables."
    );
  this.updater.enqueueSetState(this, e, t, "setState");
};
ur.prototype.forceUpdate = function (e) {
  this.updater.enqueueForceUpdate(this, e, "forceUpdate");
};
function Zc() {}
Zc.prototype = ur.prototype;
function Xs(e, t, n) {
  (this.props = e),
    (this.context = t),
    (this.refs = Kc),
    (this.updater = n || Xc);
}
var Qs = (Xs.prototype = new Zc());
Qs.constructor = Xs;
Qc(Qs, ur.prototype);
Qs.isPureReactComponent = !0;
var au = Array.isArray,
  qc = Object.prototype.hasOwnProperty,
  Ks = { current: null },
  Jc = { key: !0, ref: !0, __self: !0, __source: !0 };
function ef(e, t, n) {
  var r,
    i = {},
    o = null,
    l = null;
  if (t != null)
    for (r in (t.ref !== void 0 && (l = t.ref),
    t.key !== void 0 && (o = "" + t.key),
    t))
      qc.call(t, r) && !Jc.hasOwnProperty(r) && (i[r] = t[r]);
  var a = arguments.length - 2;
  if (a === 1) i.children = n;
  else if (1 < a) {
    for (var s = Array(a), u = 0; u < a; u++) s[u] = arguments[u + 2];
    i.children = s;
  }
  if (e && e.defaultProps)
    for (r in ((a = e.defaultProps), a)) i[r] === void 0 && (i[r] = a[r]);
  return {
    $$typeof: si,
    type: e,
    key: o,
    ref: l,
    props: i,
    _owner: Ks.current,
  };
}
function wh(e, t) {
  return {
    $$typeof: si,
    type: e.type,
    key: t,
    ref: e.ref,
    props: e.props,
    _owner: e._owner,
  };
}
function Zs(e) {
  return typeof e == "object" && e !== null && e.$$typeof === si;
}
function xh(e) {
  var t = { "=": "=0", ":": "=2" };
  return (
    "$" +
    e.replace(/[=:]/g, function (n) {
      return t[n];
    })
  );
}
var uu = /\/+/g;
function ll(e, t) {
  return typeof e == "object" && e !== null && e.key != null
    ? xh("" + e.key)
    : t.toString(36);
}
function bi(e, t, n, r, i) {
  var o = typeof e;
  (o === "undefined" || o === "boolean") && (e = null);
  var l = !1;
  if (e === null) l = !0;
  else
    switch (o) {
      case "string":
      case "number":
        l = !0;
        break;
      case "object":
        switch (e.$$typeof) {
          case si:
          case uh:
            l = !0;
        }
    }
  if (l)
    return (
      (l = e),
      (i = i(l)),
      (e = r === "" ? "." + ll(l, 0) : r),
      au(i)
        ? ((n = ""),
          e != null && (n = e.replace(uu, "$&/") + "/"),
          bi(i, t, n, "", function (u) {
            return u;
          }))
        : i != null &&
          (Zs(i) &&
            (i = wh(
              i,
              n +
                (!i.key || (l && l.key === i.key)
                  ? ""
                  : ("" + i.key).replace(uu, "$&/") + "/") +
                e
            )),
          t.push(i)),
      1
    );
  if (((l = 0), (r = r === "" ? "." : r + ":"), au(e)))
    for (var a = 0; a < e.length; a++) {
      o = e[a];
      var s = r + ll(o, a);
      l += bi(o, t, n, s, i);
    }
  else if (((s = Sh(e)), typeof s == "function"))
    for (e = s.call(e), a = 0; !(o = e.next()).done; )
      (o = o.value), (s = r + ll(o, a++)), (l += bi(o, t, n, s, i));
  else if (o === "object")
    throw (
      ((t = String(e)),
      Error(
        "Objects are not valid as a React child (found: " +
          (t === "[object Object]"
            ? "object with keys {" + Object.keys(e).join(", ") + "}"
            : t) +
          "). If you meant to render a collection of children, use an array instead."
      ))
    );
  return l;
}
function hi(e, t, n) {
  if (e == null) return e;
  var r = [],
    i = 0;
  return (
    bi(e, r, "", "", function (o) {
      return t.call(n, o, i++);
    }),
    r
  );
}
function Ch(e) {
  if (e._status === -1) {
    var t = e._result;
    (t = t()),
      t.then(
        function (n) {
          (e._status === 0 || e._status === -1) &&
            ((e._status = 1), (e._result = n));
        },
        function (n) {
          (e._status === 0 || e._status === -1) &&
            ((e._status = 2), (e._result = n));
        }
      ),
      e._status === -1 && ((e._status = 0), (e._result = t));
  }
  if (e._status === 1) return e._result.default;
  throw e._result;
}
var Be = { current: null },
  Di = { transition: null },
  Eh = {
    ReactCurrentDispatcher: Be,
    ReactCurrentBatchConfig: Di,
    ReactCurrentOwner: Ks,
  };
J.Children = {
  map: hi,
  forEach: function (e, t, n) {
    hi(
      e,
      function () {
        t.apply(this, arguments);
      },
      n
    );
  },
  count: function (e) {
    var t = 0;
    return (
      hi(e, function () {
        t++;
      }),
      t
    );
  },
  toArray: function (e) {
    return (
      hi(e, function (t) {
        return t;
      }) || []
    );
  },
  only: function (e) {
    if (!Zs(e))
      throw Error(
        "React.Children.only expected to receive a single React element child."
      );
    return e;
  },
};
J.Component = ur;
J.Fragment = ch;
J.Profiler = dh;
J.PureComponent = Xs;
J.StrictMode = fh;
J.Suspense = vh;
J.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = Eh;
J.cloneElement = function (e, t, n) {
  if (e == null)
    throw Error(
      "React.cloneElement(...): The argument must be a React element, but you passed " +
        e +
        "."
    );
  var r = Qc({}, e.props),
    i = e.key,
    o = e.ref,
    l = e._owner;
  if (t != null) {
    if (
      (t.ref !== void 0 && ((o = t.ref), (l = Ks.current)),
      t.key !== void 0 && (i = "" + t.key),
      e.type && e.type.defaultProps)
    )
      var a = e.type.defaultProps;
    for (s in t)
      qc.call(t, s) &&
        !Jc.hasOwnProperty(s) &&
        (r[s] = t[s] === void 0 && a !== void 0 ? a[s] : t[s]);
  }
  var s = arguments.length - 2;
  if (s === 1) r.children = n;
  else if (1 < s) {
    a = Array(s);
    for (var u = 0; u < s; u++) a[u] = arguments[u + 2];
    r.children = a;
  }
  return { $$typeof: si, type: e.type, key: i, ref: o, props: r, _owner: l };
};
J.createContext = function (e) {
  return (
    (e = {
      $$typeof: hh,
      _currentValue: e,
      _currentValue2: e,
      _threadCount: 0,
      Provider: null,
      Consumer: null,
      _defaultValue: null,
      _globalName: null,
    }),
    (e.Provider = { $$typeof: ph, _context: e }),
    (e.Consumer = e)
  );
};
J.createElement = ef;
J.createFactory = function (e) {
  var t = ef.bind(null, e);
  return (t.type = e), t;
};
J.createRef = function () {
  return { current: null };
};
J.forwardRef = function (e) {
  return { $$typeof: mh, render: e };
};
J.isValidElement = Zs;
J.lazy = function (e) {
  return { $$typeof: yh, _payload: { _status: -1, _result: e }, _init: Ch };
};
J.memo = function (e, t) {
  return { $$typeof: gh, type: e, compare: t === void 0 ? null : t };
};
J.startTransition = function (e) {
  var t = Di.transition;
  Di.transition = {};
  try {
    e();
  } finally {
    Di.transition = t;
  }
};
J.unstable_act = function () {
  throw Error("act(...) is not supported in production builds of React.");
};
J.useCallback = function (e, t) {
  return Be.current.useCallback(e, t);
};
J.useContext = function (e) {
  return Be.current.useContext(e);
};
J.useDebugValue = function () {};
J.useDeferredValue = function (e) {
  return Be.current.useDeferredValue(e);
};
J.useEffect = function (e, t) {
  return Be.current.useEffect(e, t);
};
J.useId = function () {
  return Be.current.useId();
};
J.useImperativeHandle = function (e, t, n) {
  return Be.current.useImperativeHandle(e, t, n);
};
J.useInsertionEffect = function (e, t) {
  return Be.current.useInsertionEffect(e, t);
};
J.useLayoutEffect = function (e, t) {
  return Be.current.useLayoutEffect(e, t);
};
J.useMemo = function (e, t) {
  return Be.current.useMemo(e, t);
};
J.useReducer = function (e, t, n) {
  return Be.current.useReducer(e, t, n);
};
J.useRef = function (e) {
  return Be.current.useRef(e);
};
J.useState = function (e) {
  return Be.current.useState(e);
};
J.useSyncExternalStore = function (e, t, n) {
  return Be.current.useSyncExternalStore(e, t, n);
};
J.useTransition = function () {
  return Be.current.useTransition();
};
J.version = "18.2.0";
A.exports = J;
var Q = A.exports,
  tf = { exports: {} },
  nf = {};
/**
 * @license React
 * scheduler.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */ (function (e) {
  function t($, O) {
    var M = $.length;
    $.push(O);
    e: for (; 0 < M; ) {
      var F = (M - 1) >>> 1,
        _ = $[F];
      if (0 < i(_, O)) ($[F] = O), ($[M] = _), (M = F);
      else break e;
    }
  }
  function n($) {
    return $.length === 0 ? null : $[0];
  }
  function r($) {
    if ($.length === 0) return null;
    var O = $[0],
      M = $.pop();
    if (M !== O) {
      $[0] = M;
      e: for (var F = 0, _ = $.length, z = _ >>> 1; F < z; ) {
        var b = 2 * (F + 1) - 1,
          W = $[b],
          C = b + 1,
          Y = $[C];
        if (0 > i(W, M))
          C < _ && 0 > i(Y, W)
            ? (($[F] = Y), ($[C] = M), (F = C))
            : (($[F] = W), ($[b] = M), (F = b));
        else if (C < _ && 0 > i(Y, M)) ($[F] = Y), ($[C] = M), (F = C);
        else break e;
      }
    }
    return O;
  }
  function i($, O) {
    var M = $.sortIndex - O.sortIndex;
    return M !== 0 ? M : $.id - O.id;
  }
  if (typeof performance == "object" && typeof performance.now == "function") {
    var o = performance;
    e.unstable_now = function () {
      return o.now();
    };
  } else {
    var l = Date,
      a = l.now();
    e.unstable_now = function () {
      return l.now() - a;
    };
  }
  var s = [],
    u = [],
    c = 1,
    f = null,
    d = 3,
    v = !1,
    g = !1,
    y = !1,
    x = typeof setTimeout == "function" ? setTimeout : null,
    h = typeof clearTimeout == "function" ? clearTimeout : null,
    p = typeof setImmediate != "undefined" ? setImmediate : null;
  typeof navigator != "undefined" &&
    navigator.scheduling !== void 0 &&
    navigator.scheduling.isInputPending !== void 0 &&
    navigator.scheduling.isInputPending.bind(navigator.scheduling);
  function m($) {
    for (var O = n(u); O !== null; ) {
      if (O.callback === null) r(u);
      else if (O.startTime <= $)
        r(u), (O.sortIndex = O.expirationTime), t(s, O);
      else break;
      O = n(u);
    }
  }
  function S($) {
    if (((y = !1), m($), !g))
      if (n(s) !== null) (g = !0), Z(w);
      else {
        var O = n(u);
        O !== null && q(S, O.startTime - $);
      }
  }
  function w($, O) {
    (g = !1), y && ((y = !1), h(k), (k = -1)), (v = !0);
    var M = d;
    try {
      for (
        m(O), f = n(s);
        f !== null && (!(f.expirationTime > O) || ($ && !T()));

      ) {
        var F = f.callback;
        if (typeof F == "function") {
          (f.callback = null), (d = f.priorityLevel);
          var _ = F(f.expirationTime <= O);
          (O = e.unstable_now()),
            typeof _ == "function" ? (f.callback = _) : f === n(s) && r(s),
            m(O);
        } else r(s);
        f = n(s);
      }
      if (f !== null) var z = !0;
      else {
        var b = n(u);
        b !== null && q(S, b.startTime - O), (z = !1);
      }
      return z;
    } finally {
      (f = null), (d = M), (v = !1);
    }
  }
  var P = !1,
    E = null,
    k = -1,
    D = 5,
    L = -1;
  function T() {
    return !(e.unstable_now() - L < D);
  }
  function N() {
    if (E !== null) {
      var $ = e.unstable_now();
      L = $;
      var O = !0;
      try {
        O = E(!0, $);
      } finally {
        O ? j() : ((P = !1), (E = null));
      }
    } else P = !1;
  }
  var j;
  if (typeof p == "function")
    j = function () {
      p(N);
    };
  else if (typeof MessageChannel != "undefined") {
    var U = new MessageChannel(),
      B = U.port2;
    (U.port1.onmessage = N),
      (j = function () {
        B.postMessage(null);
      });
  } else
    j = function () {
      x(N, 0);
    };
  function Z($) {
    (E = $), P || ((P = !0), j());
  }
  function q($, O) {
    k = x(function () {
      $(e.unstable_now());
    }, O);
  }
  (e.unstable_IdlePriority = 5),
    (e.unstable_ImmediatePriority = 1),
    (e.unstable_LowPriority = 4),
    (e.unstable_NormalPriority = 3),
    (e.unstable_Profiling = null),
    (e.unstable_UserBlockingPriority = 2),
    (e.unstable_cancelCallback = function ($) {
      $.callback = null;
    }),
    (e.unstable_continueExecution = function () {
      g || v || ((g = !0), Z(w));
    }),
    (e.unstable_forceFrameRate = function ($) {
      0 > $ || 125 < $
        ? console.error()
        : (D = 0 < $ ? Math.floor(1e3 / $) : 5);
    }),
    (e.unstable_getCurrentPriorityLevel = function () {
      return d;
    }),
    (e.unstable_getFirstCallbackNode = function () {
      return n(s);
    }),
    (e.unstable_next = function ($) {
      switch (d) {
        case 1:
        case 2:
        case 3:
          var O = 3;
          break;
        default:
          O = d;
      }
      var M = d;
      d = O;
      try {
        return $();
      } finally {
        d = M;
      }
    }),
    (e.unstable_pauseExecution = function () {}),
    (e.unstable_requestPaint = function () {}),
    (e.unstable_runWithPriority = function ($, O) {
      switch ($) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
          break;
        default:
          $ = 3;
      }
      var M = d;
      d = $;
      try {
        return O();
      } finally {
        d = M;
      }
    }),
    (e.unstable_scheduleCallback = function ($, O, M) {
      var F = e.unstable_now();
      switch (
        (typeof M == "object" && M !== null
          ? ((M = M.delay), (M = typeof M == "number" && 0 < M ? F + M : F))
          : (M = F),
        $)
      ) {
        case 1:
          var _ = -1;
          break;
        case 2:
          _ = 250;
          break;
        case 5:
          _ = 1073741823;
          break;
        case 4:
          _ = 1e4;
          break;
        default:
          _ = 5e3;
      }
      return (
        (_ = M + _),
        ($ = {
          id: c++,
          callback: O,
          priorityLevel: $,
          startTime: M,
          expirationTime: _,
          sortIndex: -1,
        }),
        M > F
          ? (($.sortIndex = M),
            t(u, $),
            n(s) === null &&
              $ === n(u) &&
              (y ? (h(k), (k = -1)) : (y = !0), q(S, M - F)))
          : (($.sortIndex = _), t(s, $), g || v || ((g = !0), Z(w))),
        $
      );
    }),
    (e.unstable_shouldYield = T),
    (e.unstable_wrapCallback = function ($) {
      var O = d;
      return function () {
        var M = d;
        d = O;
        try {
          return $.apply(this, arguments);
        } finally {
          d = M;
        }
      };
    });
})(nf);
tf.exports = nf;
/**
 * @license React
 * react-dom.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */ var rf = A.exports,
  nt = tf.exports;
function R(e) {
  for (
    var t = "https://reactjs.org/docs/error-decoder.html?invariant=" + e, n = 1;
    n < arguments.length;
    n++
  )
    t += "&args[]=" + encodeURIComponent(arguments[n]);
  return (
    "Minified React error #" +
    e +
    "; visit " +
    t +
    " for the full message or use the non-minified dev environment for full errors and additional helpful warnings."
  );
}
var of = new Set(),
  Vr = {};
function Pn(e, t) {
  Qn(e, t), Qn(e + "Capture", t);
}
function Qn(e, t) {
  for (Vr[e] = t, e = 0; e < t.length; e++) of.add(t[e]);
}
var Nt = !(
    typeof window == "undefined" ||
    typeof window.document == "undefined" ||
    typeof window.document.createElement == "undefined"
  ),
  Wl = Object.prototype.hasOwnProperty,
  Th =
    /^[:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD][:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD\-.0-9\u00B7\u0300-\u036F\u203F-\u2040]*$/,
  cu = {},
  fu = {};
function kh(e) {
  return Wl.call(fu, e)
    ? !0
    : Wl.call(cu, e)
    ? !1
    : Th.test(e)
    ? (fu[e] = !0)
    : ((cu[e] = !0), !1);
}
function Ph(e, t, n, r) {
  if (n !== null && n.type === 0) return !1;
  switch (typeof t) {
    case "function":
    case "symbol":
      return !0;
    case "boolean":
      return r
        ? !1
        : n !== null
        ? !n.acceptsBooleans
        : ((e = e.toLowerCase().slice(0, 5)), e !== "data-" && e !== "aria-");
    default:
      return !1;
  }
}
function $h(e, t, n, r) {
  if (t === null || typeof t == "undefined" || Ph(e, t, n, r)) return !0;
  if (r) return !1;
  if (n !== null)
    switch (n.type) {
      case 3:
        return !t;
      case 4:
        return t === !1;
      case 5:
        return isNaN(t);
      case 6:
        return isNaN(t) || 1 > t;
    }
  return !1;
}
function Ve(e, t, n, r, i, o, l) {
  (this.acceptsBooleans = t === 2 || t === 3 || t === 4),
    (this.attributeName = r),
    (this.attributeNamespace = i),
    (this.mustUseProperty = n),
    (this.propertyName = e),
    (this.type = t),
    (this.sanitizeURL = o),
    (this.removeEmptyString = l);
}
var Ne = {};
"children dangerouslySetInnerHTML defaultValue defaultChecked innerHTML suppressContentEditableWarning suppressHydrationWarning style"
  .split(" ")
  .forEach(function (e) {
    Ne[e] = new Ve(e, 0, !1, e, null, !1, !1);
  });
[
  ["acceptCharset", "accept-charset"],
  ["className", "class"],
  ["htmlFor", "for"],
  ["httpEquiv", "http-equiv"],
].forEach(function (e) {
  var t = e[0];
  Ne[t] = new Ve(t, 1, !1, e[1], null, !1, !1);
});
["contentEditable", "draggable", "spellCheck", "value"].forEach(function (e) {
  Ne[e] = new Ve(e, 2, !1, e.toLowerCase(), null, !1, !1);
});
[
  "autoReverse",
  "externalResourcesRequired",
  "focusable",
  "preserveAlpha",
].forEach(function (e) {
  Ne[e] = new Ve(e, 2, !1, e, null, !1, !1);
});
"allowFullScreen async autoFocus autoPlay controls default defer disabled disablePictureInPicture disableRemotePlayback formNoValidate hidden loop noModule noValidate open playsInline readOnly required reversed scoped seamless itemScope"
  .split(" ")
  .forEach(function (e) {
    Ne[e] = new Ve(e, 3, !1, e.toLowerCase(), null, !1, !1);
  });
["checked", "multiple", "muted", "selected"].forEach(function (e) {
  Ne[e] = new Ve(e, 3, !0, e, null, !1, !1);
});
["capture", "download"].forEach(function (e) {
  Ne[e] = new Ve(e, 4, !1, e, null, !1, !1);
});
["cols", "rows", "size", "span"].forEach(function (e) {
  Ne[e] = new Ve(e, 6, !1, e, null, !1, !1);
});
["rowSpan", "start"].forEach(function (e) {
  Ne[e] = new Ve(e, 5, !1, e.toLowerCase(), null, !1, !1);
});
var qs = /[\-:]([a-z])/g;
function Js(e) {
  return e[1].toUpperCase();
}
"accent-height alignment-baseline arabic-form baseline-shift cap-height clip-path clip-rule color-interpolation color-interpolation-filters color-profile color-rendering dominant-baseline enable-background fill-opacity fill-rule flood-color flood-opacity font-family font-size font-size-adjust font-stretch font-style font-variant font-weight glyph-name glyph-orientation-horizontal glyph-orientation-vertical horiz-adv-x horiz-origin-x image-rendering letter-spacing lighting-color marker-end marker-mid marker-start overline-position overline-thickness paint-order panose-1 pointer-events rendering-intent shape-rendering stop-color stop-opacity strikethrough-position strikethrough-thickness stroke-dasharray stroke-dashoffset stroke-linecap stroke-linejoin stroke-miterlimit stroke-opacity stroke-width text-anchor text-decoration text-rendering underline-position underline-thickness unicode-bidi unicode-range units-per-em v-alphabetic v-hanging v-ideographic v-mathematical vector-effect vert-adv-y vert-origin-x vert-origin-y word-spacing writing-mode xmlns:xlink x-height"
  .split(" ")
  .forEach(function (e) {
    var t = e.replace(qs, Js);
    Ne[t] = new Ve(t, 1, !1, e, null, !1, !1);
  });
"xlink:actuate xlink:arcrole xlink:role xlink:show xlink:title xlink:type"
  .split(" ")
  .forEach(function (e) {
    var t = e.replace(qs, Js);
    Ne[t] = new Ve(t, 1, !1, e, "http://www.w3.org/1999/xlink", !1, !1);
  });
["xml:base", "xml:lang", "xml:space"].forEach(function (e) {
  var t = e.replace(qs, Js);
  Ne[t] = new Ve(t, 1, !1, e, "http://www.w3.org/XML/1998/namespace", !1, !1);
});
["tabIndex", "crossOrigin"].forEach(function (e) {
  Ne[e] = new Ve(e, 1, !1, e.toLowerCase(), null, !1, !1);
});
Ne.xlinkHref = new Ve(
  "xlinkHref",
  1,
  !1,
  "xlink:href",
  "http://www.w3.org/1999/xlink",
  !0,
  !1
);
["src", "href", "action", "formAction"].forEach(function (e) {
  Ne[e] = new Ve(e, 1, !1, e.toLowerCase(), null, !0, !0);
});
function ea(e, t, n, r) {
  var i = Ne.hasOwnProperty(t) ? Ne[t] : null;
  (i !== null
    ? i.type !== 0
    : r ||
      !(2 < t.length) ||
      (t[0] !== "o" && t[0] !== "O") ||
      (t[1] !== "n" && t[1] !== "N")) &&
    ($h(t, n, i, r) && (n = null),
    r || i === null
      ? kh(t) && (n === null ? e.removeAttribute(t) : e.setAttribute(t, "" + n))
      : i.mustUseProperty
      ? (e[i.propertyName] = n === null ? (i.type === 3 ? !1 : "") : n)
      : ((t = i.attributeName),
        (r = i.attributeNamespace),
        n === null
          ? e.removeAttribute(t)
          : ((i = i.type),
            (n = i === 3 || (i === 4 && n === !0) ? "" : "" + n),
            r ? e.setAttributeNS(r, t, n) : e.setAttribute(t, n))));
}
var It = rf.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED,
  mi = Symbol.for("react.element"),
  On = Symbol.for("react.portal"),
  Mn = Symbol.for("react.fragment"),
  ta = Symbol.for("react.strict_mode"),
  Gl = Symbol.for("react.profiler"),
  lf = Symbol.for("react.provider"),
  sf = Symbol.for("react.context"),
  na = Symbol.for("react.forward_ref"),
  Yl = Symbol.for("react.suspense"),
  Xl = Symbol.for("react.suspense_list"),
  ra = Symbol.for("react.memo"),
  jt = Symbol.for("react.lazy"),
  af = Symbol.for("react.offscreen"),
  du = Symbol.iterator;
function gr(e) {
  return e === null || typeof e != "object"
    ? null
    : ((e = (du && e[du]) || e["@@iterator"]),
      typeof e == "function" ? e : null);
}
var he = Object.assign,
  sl;
function Pr(e) {
  if (sl === void 0)
    try {
      throw Error();
    } catch (n) {
      var t = n.stack.trim().match(/\n( *(at )?)/);
      sl = (t && t[1]) || "";
    }
  return (
    `
` +
    sl +
    e
  );
}
var al = !1;
function ul(e, t) {
  if (!e || al) return "";
  al = !0;
  var n = Error.prepareStackTrace;
  Error.prepareStackTrace = void 0;
  try {
    if (t)
      if (
        ((t = function () {
          throw Error();
        }),
        Object.defineProperty(t.prototype, "props", {
          set: function () {
            throw Error();
          },
        }),
        typeof Reflect == "object" && Reflect.construct)
      ) {
        try {
          Reflect.construct(t, []);
        } catch (u) {
          var r = u;
        }
        Reflect.construct(e, [], t);
      } else {
        try {
          t.call();
        } catch (u) {
          r = u;
        }
        e.call(t.prototype);
      }
    else {
      try {
        throw Error();
      } catch (u) {
        r = u;
      }
      e();
    }
  } catch (u) {
    if (u && r && typeof u.stack == "string") {
      for (
        var i = u.stack.split(`
`),
          o = r.stack.split(`
`),
          l = i.length - 1,
          a = o.length - 1;
        1 <= l && 0 <= a && i[l] !== o[a];

      )
        a--;
      for (; 1 <= l && 0 <= a; l--, a--)
        if (i[l] !== o[a]) {
          if (l !== 1 || a !== 1)
            do
              if ((l--, a--, 0 > a || i[l] !== o[a])) {
                var s =
                  `
` + i[l].replace(" at new ", " at ");
                return (
                  e.displayName &&
                    s.includes("<anonymous>") &&
                    (s = s.replace("<anonymous>", e.displayName)),
                  s
                );
              }
            while (1 <= l && 0 <= a);
          break;
        }
    }
  } finally {
    (al = !1), (Error.prepareStackTrace = n);
  }
  return (e = e ? e.displayName || e.name : "") ? Pr(e) : "";
}
function _h(e) {
  switch (e.tag) {
    case 5:
      return Pr(e.type);
    case 16:
      return Pr("Lazy");
    case 13:
      return Pr("Suspense");
    case 19:
      return Pr("SuspenseList");
    case 0:
    case 2:
    case 15:
      return (e = ul(e.type, !1)), e;
    case 11:
      return (e = ul(e.type.render, !1)), e;
    case 1:
      return (e = ul(e.type, !0)), e;
    default:
      return "";
  }
}
function Ql(e) {
  if (e == null) return null;
  if (typeof e == "function") return e.displayName || e.name || null;
  if (typeof e == "string") return e;
  switch (e) {
    case Mn:
      return "Fragment";
    case On:
      return "Portal";
    case Gl:
      return "Profiler";
    case ta:
      return "StrictMode";
    case Yl:
      return "Suspense";
    case Xl:
      return "SuspenseList";
  }
  if (typeof e == "object")
    switch (e.$$typeof) {
      case sf:
        return (e.displayName || "Context") + ".Consumer";
      case lf:
        return (e._context.displayName || "Context") + ".Provider";
      case na:
        var t = e.render;
        return (
          (e = e.displayName),
          e ||
            ((e = t.displayName || t.name || ""),
            (e = e !== "" ? "ForwardRef(" + e + ")" : "ForwardRef")),
          e
        );
      case ra:
        return (
          (t = e.displayName || null), t !== null ? t : Ql(e.type) || "Memo"
        );
      case jt:
        (t = e._payload), (e = e._init);
        try {
          return Ql(e(t));
        } catch {}
    }
  return null;
}
function Lh(e) {
  var t = e.type;
  switch (e.tag) {
    case 24:
      return "Cache";
    case 9:
      return (t.displayName || "Context") + ".Consumer";
    case 10:
      return (t._context.displayName || "Context") + ".Provider";
    case 18:
      return "DehydratedFragment";
    case 11:
      return (
        (e = t.render),
        (e = e.displayName || e.name || ""),
        t.displayName || (e !== "" ? "ForwardRef(" + e + ")" : "ForwardRef")
      );
    case 7:
      return "Fragment";
    case 5:
      return t;
    case 4:
      return "Portal";
    case 3:
      return "Root";
    case 6:
      return "Text";
    case 16:
      return Ql(t);
    case 8:
      return t === ta ? "StrictMode" : "Mode";
    case 22:
      return "Offscreen";
    case 12:
      return "Profiler";
    case 21:
      return "Scope";
    case 13:
      return "Suspense";
    case 19:
      return "SuspenseList";
    case 25:
      return "TracingMarker";
    case 1:
    case 0:
    case 17:
    case 2:
    case 14:
    case 15:
      if (typeof t == "function") return t.displayName || t.name || null;
      if (typeof t == "string") return t;
  }
  return null;
}
function nn(e) {
  switch (typeof e) {
    case "boolean":
    case "number":
    case "string":
    case "undefined":
      return e;
    case "object":
      return e;
    default:
      return "";
  }
}
function uf(e) {
  var t = e.type;
  return (
    (e = e.nodeName) &&
    e.toLowerCase() === "input" &&
    (t === "checkbox" || t === "radio")
  );
}
function Oh(e) {
  var t = uf(e) ? "checked" : "value",
    n = Object.getOwnPropertyDescriptor(e.constructor.prototype, t),
    r = "" + e[t];
  if (
    !e.hasOwnProperty(t) &&
    typeof n != "undefined" &&
    typeof n.get == "function" &&
    typeof n.set == "function"
  ) {
    var i = n.get,
      o = n.set;
    return (
      Object.defineProperty(e, t, {
        configurable: !0,
        get: function () {
          return i.call(this);
        },
        set: function (l) {
          (r = "" + l), o.call(this, l);
        },
      }),
      Object.defineProperty(e, t, { enumerable: n.enumerable }),
      {
        getValue: function () {
          return r;
        },
        setValue: function (l) {
          r = "" + l;
        },
        stopTracking: function () {
          (e._valueTracker = null), delete e[t];
        },
      }
    );
  }
}
function vi(e) {
  e._valueTracker || (e._valueTracker = Oh(e));
}
function cf(e) {
  if (!e) return !1;
  var t = e._valueTracker;
  if (!t) return !0;
  var n = t.getValue(),
    r = "";
  return (
    e && (r = uf(e) ? (e.checked ? "true" : "false") : e.value),
    (e = r),
    e !== n ? (t.setValue(e), !0) : !1
  );
}
function Zi(e) {
  if (
    ((e = e || (typeof document != "undefined" ? document : void 0)),
    typeof e == "undefined")
  )
    return null;
  try {
    return e.activeElement || e.body;
  } catch {
    return e.body;
  }
}
function Kl(e, t) {
  var n = t.checked;
  return he({}, t, {
    defaultChecked: void 0,
    defaultValue: void 0,
    value: void 0,
    checked: n != null ? n : e._wrapperState.initialChecked,
  });
}
function pu(e, t) {
  var n = t.defaultValue == null ? "" : t.defaultValue,
    r = t.checked != null ? t.checked : t.defaultChecked;
  (n = nn(t.value != null ? t.value : n)),
    (e._wrapperState = {
      initialChecked: r,
      initialValue: n,
      controlled:
        t.type === "checkbox" || t.type === "radio"
          ? t.checked != null
          : t.value != null,
    });
}
function ff(e, t) {
  (t = t.checked), t != null && ea(e, "checked", t, !1);
}
function Zl(e, t) {
  ff(e, t);
  var n = nn(t.value),
    r = t.type;
  if (n != null)
    r === "number"
      ? ((n === 0 && e.value === "") || e.value != n) && (e.value = "" + n)
      : e.value !== "" + n && (e.value = "" + n);
  else if (r === "submit" || r === "reset") {
    e.removeAttribute("value");
    return;
  }
  t.hasOwnProperty("value")
    ? ql(e, t.type, n)
    : t.hasOwnProperty("defaultValue") && ql(e, t.type, nn(t.defaultValue)),
    t.checked == null &&
      t.defaultChecked != null &&
      (e.defaultChecked = !!t.defaultChecked);
}
function hu(e, t, n) {
  if (t.hasOwnProperty("value") || t.hasOwnProperty("defaultValue")) {
    var r = t.type;
    if (
      !(
        (r !== "submit" && r !== "reset") ||
        (t.value !== void 0 && t.value !== null)
      )
    )
      return;
    (t = "" + e._wrapperState.initialValue),
      n || t === e.value || (e.value = t),
      (e.defaultValue = t);
  }
  (n = e.name),
    n !== "" && (e.name = ""),
    (e.defaultChecked = !!e._wrapperState.initialChecked),
    n !== "" && (e.name = n);
}
function ql(e, t, n) {
  (t !== "number" || Zi(e.ownerDocument) !== e) &&
    (n == null
      ? (e.defaultValue = "" + e._wrapperState.initialValue)
      : e.defaultValue !== "" + n && (e.defaultValue = "" + n));
}
var $r = Array.isArray;
function Hn(e, t, n, r) {
  if (((e = e.options), t)) {
    t = {};
    for (var i = 0; i < n.length; i++) t["$" + n[i]] = !0;
    for (n = 0; n < e.length; n++)
      (i = t.hasOwnProperty("$" + e[n].value)),
        e[n].selected !== i && (e[n].selected = i),
        i && r && (e[n].defaultSelected = !0);
  } else {
    for (n = "" + nn(n), t = null, i = 0; i < e.length; i++) {
      if (e[i].value === n) {
        (e[i].selected = !0), r && (e[i].defaultSelected = !0);
        return;
      }
      t !== null || e[i].disabled || (t = e[i]);
    }
    t !== null && (t.selected = !0);
  }
}
function Jl(e, t) {
  if (t.dangerouslySetInnerHTML != null) throw Error(R(91));
  return he({}, t, {
    value: void 0,
    defaultValue: void 0,
    children: "" + e._wrapperState.initialValue,
  });
}
function mu(e, t) {
  var n = t.value;
  if (n == null) {
    if (((n = t.children), (t = t.defaultValue), n != null)) {
      if (t != null) throw Error(R(92));
      if ($r(n)) {
        if (1 < n.length) throw Error(R(93));
        n = n[0];
      }
      t = n;
    }
    t == null && (t = ""), (n = t);
  }
  e._wrapperState = { initialValue: nn(n) };
}
function df(e, t) {
  var n = nn(t.value),
    r = nn(t.defaultValue);
  n != null &&
    ((n = "" + n),
    n !== e.value && (e.value = n),
    t.defaultValue == null && e.defaultValue !== n && (e.defaultValue = n)),
    r != null && (e.defaultValue = "" + r);
}
function vu(e) {
  var t = e.textContent;
  t === e._wrapperState.initialValue && t !== "" && t !== null && (e.value = t);
}
function pf(e) {
  switch (e) {
    case "svg":
      return "http://www.w3.org/2000/svg";
    case "math":
      return "http://www.w3.org/1998/Math/MathML";
    default:
      return "http://www.w3.org/1999/xhtml";
  }
}
function es(e, t) {
  return e == null || e === "http://www.w3.org/1999/xhtml"
    ? pf(t)
    : e === "http://www.w3.org/2000/svg" && t === "foreignObject"
    ? "http://www.w3.org/1999/xhtml"
    : e;
}
var gi,
  hf = (function (e) {
    return typeof MSApp != "undefined" && MSApp.execUnsafeLocalFunction
      ? function (t, n, r, i) {
          MSApp.execUnsafeLocalFunction(function () {
            return e(t, n, r, i);
          });
        }
      : e;
  })(function (e, t) {
    if (e.namespaceURI !== "http://www.w3.org/2000/svg" || "innerHTML" in e)
      e.innerHTML = t;
    else {
      for (
        gi = gi || document.createElement("div"),
          gi.innerHTML = "<svg>" + t.valueOf().toString() + "</svg>",
          t = gi.firstChild;
        e.firstChild;

      )
        e.removeChild(e.firstChild);
      for (; t.firstChild; ) e.appendChild(t.firstChild);
    }
  });
function Hr(e, t) {
  if (t) {
    var n = e.firstChild;
    if (n && n === e.lastChild && n.nodeType === 3) {
      n.nodeValue = t;
      return;
    }
  }
  e.textContent = t;
}
var Or = {
    animationIterationCount: !0,
    aspectRatio: !0,
    borderImageOutset: !0,
    borderImageSlice: !0,
    borderImageWidth: !0,
    boxFlex: !0,
    boxFlexGroup: !0,
    boxOrdinalGroup: !0,
    columnCount: !0,
    columns: !0,
    flex: !0,
    flexGrow: !0,
    flexPositive: !0,
    flexShrink: !0,
    flexNegative: !0,
    flexOrder: !0,
    gridArea: !0,
    gridRow: !0,
    gridRowEnd: !0,
    gridRowSpan: !0,
    gridRowStart: !0,
    gridColumn: !0,
    gridColumnEnd: !0,
    gridColumnSpan: !0,
    gridColumnStart: !0,
    fontWeight: !0,
    lineClamp: !0,
    lineHeight: !0,
    opacity: !0,
    order: !0,
    orphans: !0,
    tabSize: !0,
    widows: !0,
    zIndex: !0,
    zoom: !0,
    fillOpacity: !0,
    floodOpacity: !0,
    stopOpacity: !0,
    strokeDasharray: !0,
    strokeDashoffset: !0,
    strokeMiterlimit: !0,
    strokeOpacity: !0,
    strokeWidth: !0,
  },
  Mh = ["Webkit", "ms", "Moz", "O"];
Object.keys(Or).forEach(function (e) {
  Mh.forEach(function (t) {
    (t = t + e.charAt(0).toUpperCase() + e.substring(1)), (Or[t] = Or[e]);
  });
});
function mf(e, t, n) {
  return t == null || typeof t == "boolean" || t === ""
    ? ""
    : n || typeof t != "number" || t === 0 || (Or.hasOwnProperty(e) && Or[e])
    ? ("" + t).trim()
    : t + "px";
}
function vf(e, t) {
  e = e.style;
  for (var n in t)
    if (t.hasOwnProperty(n)) {
      var r = n.indexOf("--") === 0,
        i = mf(n, t[n], r);
      n === "float" && (n = "cssFloat"), r ? e.setProperty(n, i) : (e[n] = i);
    }
}
var Nh = he(
  { menuitem: !0 },
  {
    area: !0,
    base: !0,
    br: !0,
    col: !0,
    embed: !0,
    hr: !0,
    // img: !0,
    input: !0,
    keygen: !0,
    link: !0,
    meta: !0,
    param: !0,
    source: !0,
    track: !0,
    wbr: !0,
  }
);
function ts(e, t) {
  if (t) {
    if (Nh[e] && (t.children != null || t.dangerouslySetInnerHTML != null))
      throw Error(R(137, e));
    if (t.dangerouslySetInnerHTML != null) {
      if (t.children != null) throw Error(R(60));
      if (
        typeof t.dangerouslySetInnerHTML != "object" ||
        !("__html" in t.dangerouslySetInnerHTML)
      )
        throw Error(R(61));
    }
    if (t.style != null && typeof t.style != "object") throw Error(R(62));
  }
}
function ns(e, t) {
  if (e.indexOf("-") === -1) return typeof t.is == "string";
  switch (e) {
    case "annotation-xml":
    case "color-profile":
    case "font-face":
    case "font-face-src":
    case "font-face-uri":
    case "font-face-format":
    case "font-face-name":
    case "missing-glyph":
      return !1;
    default:
      return !0;
  }
}
var rs = null;
function ia(e) {
  return (
    (e = e.target || e.srcElement || window),
    e.correspondingUseElement && (e = e.correspondingUseElement),
    e.nodeType === 3 ? e.parentNode : e
  );
}
var is = null,
  Un = null,
  Wn = null;
function gu(e) {
  if ((e = ci(e))) {
    if (typeof is != "function") throw Error(R(280));
    var t = e.stateNode;
    t && ((t = No(t)), is(e.stateNode, e.type, t));
  }
}
function gf(e) {
  Un ? (Wn ? Wn.push(e) : (Wn = [e])) : (Un = e);
}
function yf() {
  if (Un) {
    var e = Un,
      t = Wn;
    if (((Wn = Un = null), gu(e), t)) for (e = 0; e < t.length; e++) gu(t[e]);
  }
}
function Sf(e, t) {
  return e(t);
}
function wf() {}
var cl = !1;
function xf(e, t, n) {
  if (cl) return e(t, n);
  cl = !0;
  try {
    return Sf(e, t, n);
  } finally {
    (cl = !1), (Un !== null || Wn !== null) && (wf(), yf());
  }
}
function Ur(e, t) {
  var n = e.stateNode;
  if (n === null) return null;
  var r = No(n);
  if (r === null) return null;
  n = r[t];
  e: switch (t) {
    case "onClick":
    case "onClickCapture":
    case "onDoubleClick":
    case "onDoubleClickCapture":
    case "onMouseDown":
    case "onMouseDownCapture":
    case "onMouseMove":
    case "onMouseMoveCapture":
    case "onMouseUp":
    case "onMouseUpCapture":
    case "onMouseEnter":
      (r = !r.disabled) ||
        ((e = e.type),
        (r = !(
          e === "button" ||
          e === "input" ||
          e === "select" ||
          e === "textarea"
        ))),
        (e = !r);
      break e;
    default:
      e = !1;
  }
  if (e) return null;
  if (n && typeof n != "function") throw Error(R(231, t, typeof n));
  return n;
}
var os = !1;
if (Nt)
  try {
    var yr = {};
    Object.defineProperty(yr, "passive", {
      get: function () {
        os = !0;
      },
    }),
      window.addEventListener("test", yr, yr),
      window.removeEventListener("test", yr, yr);
  } catch {
    os = !1;
  }
function Ah(e, t, n, r, i, o, l, a, s) {
  var u = Array.prototype.slice.call(arguments, 3);
  try {
    t.apply(n, u);
  } catch (c) {
    this.onError(c);
  }
}
var Mr = !1,
  qi = null,
  Ji = !1,
  ls = null,
  zh = {
    onError: function (e) {
      (Mr = !0), (qi = e);
    },
  };
function Rh(e, t, n, r, i, o, l, a, s) {
  (Mr = !1), (qi = null), Ah.apply(zh, arguments);
}
function Ih(e, t, n, r, i, o, l, a, s) {
  if ((Rh.apply(this, arguments), Mr)) {
    if (Mr) {
      var u = qi;
      (Mr = !1), (qi = null);
    } else throw Error(R(198));
    Ji || ((Ji = !0), (ls = u));
  }
}
function $n(e) {
  var t = e,
    n = e;
  if (e.alternate) for (; t.return; ) t = t.return;
  else {
    e = t;
    do (t = e), (t.flags & 4098) !== 0 && (n = t.return), (e = t.return);
    while (e);
  }
  return t.tag === 3 ? n : null;
}
function Cf(e) {
  if (e.tag === 13) {
    var t = e.memoizedState;
    if (
      (t === null && ((e = e.alternate), e !== null && (t = e.memoizedState)),
      t !== null)
    )
      return t.dehydrated;
  }
  return null;
}
function yu(e) {
  if ($n(e) !== e) throw Error(R(188));
}
function bh(e) {
  var t = e.alternate;
  if (!t) {
    if (((t = $n(e)), t === null)) throw Error(R(188));
    return t !== e ? null : e;
  }
  for (var n = e, r = t; ; ) {
    var i = n.return;
    if (i === null) break;
    var o = i.alternate;
    if (o === null) {
      if (((r = i.return), r !== null)) {
        n = r;
        continue;
      }
      break;
    }
    if (i.child === o.child) {
      for (o = i.child; o; ) {
        if (o === n) return yu(i), e;
        if (o === r) return yu(i), t;
        o = o.sibling;
      }
      throw Error(R(188));
    }
    if (n.return !== r.return) (n = i), (r = o);
    else {
      for (var l = !1, a = i.child; a; ) {
        if (a === n) {
          (l = !0), (n = i), (r = o);
          break;
        }
        if (a === r) {
          (l = !0), (r = i), (n = o);
          break;
        }
        a = a.sibling;
      }
      if (!l) {
        for (a = o.child; a; ) {
          if (a === n) {
            (l = !0), (n = o), (r = i);
            break;
          }
          if (a === r) {
            (l = !0), (r = o), (n = i);
            break;
          }
          a = a.sibling;
        }
        if (!l) throw Error(R(189));
      }
    }
    if (n.alternate !== r) throw Error(R(190));
  }
  if (n.tag !== 3) throw Error(R(188));
  return n.stateNode.current === n ? e : t;
}
function Ef(e) {
  return (e = bh(e)), e !== null ? Tf(e) : null;
}
function Tf(e) {
  if (e.tag === 5 || e.tag === 6) return e;
  for (e = e.child; e !== null; ) {
    var t = Tf(e);
    if (t !== null) return t;
    e = e.sibling;
  }
  return null;
}
var kf = nt.unstable_scheduleCallback,
  Su = nt.unstable_cancelCallback,
  Dh = nt.unstable_shouldYield,
  jh = nt.unstable_requestPaint,
  ye = nt.unstable_now,
  Fh = nt.unstable_getCurrentPriorityLevel,
  oa = nt.unstable_ImmediatePriority,
  Pf = nt.unstable_UserBlockingPriority,
  eo = nt.unstable_NormalPriority,
  Bh = nt.unstable_LowPriority,
  $f = nt.unstable_IdlePriority,
  _o = null,
  kt = null;
function Vh(e) {
  if (kt && typeof kt.onCommitFiberRoot == "function")
    try {
      kt.onCommitFiberRoot(_o, e, void 0, (e.current.flags & 128) === 128);
    } catch {}
}
var St = Math.clz32 ? Math.clz32 : Wh,
  Hh = Math.log,
  Uh = Math.LN2;
function Wh(e) {
  return (e >>>= 0), e === 0 ? 32 : (31 - ((Hh(e) / Uh) | 0)) | 0;
}
var yi = 64,
  Si = 4194304;
function _r(e) {
  switch (e & -e) {
    case 1:
      return 1;
    case 2:
      return 2;
    case 4:
      return 4;
    case 8:
      return 8;
    case 16:
      return 16;
    case 32:
      return 32;
    case 64:
    case 128:
    case 256:
    case 512:
    case 1024:
    case 2048:
    case 4096:
    case 8192:
    case 16384:
    case 32768:
    case 65536:
    case 131072:
    case 262144:
    case 524288:
    case 1048576:
    case 2097152:
      return e & 4194240;
    case 4194304:
    case 8388608:
    case 16777216:
    case 33554432:
    case 67108864:
      return e & 130023424;
    case 134217728:
      return 134217728;
    case 268435456:
      return 268435456;
    case 536870912:
      return 536870912;
    case 1073741824:
      return 1073741824;
    default:
      return e;
  }
}
function to(e, t) {
  var n = e.pendingLanes;
  if (n === 0) return 0;
  var r = 0,
    i = e.suspendedLanes,
    o = e.pingedLanes,
    l = n & 268435455;
  if (l !== 0) {
    var a = l & ~i;
    a !== 0 ? (r = _r(a)) : ((o &= l), o !== 0 && (r = _r(o)));
  } else (l = n & ~i), l !== 0 ? (r = _r(l)) : o !== 0 && (r = _r(o));
  if (r === 0) return 0;
  if (
    t !== 0 &&
    t !== r &&
    (t & i) === 0 &&
    ((i = r & -r), (o = t & -t), i >= o || (i === 16 && (o & 4194240) !== 0))
  )
    return t;
  if (((r & 4) !== 0 && (r |= n & 16), (t = e.entangledLanes), t !== 0))
    for (e = e.entanglements, t &= r; 0 < t; )
      (n = 31 - St(t)), (i = 1 << n), (r |= e[n]), (t &= ~i);
  return r;
}
function Gh(e, t) {
  switch (e) {
    case 1:
    case 2:
    case 4:
      return t + 250;
    case 8:
    case 16:
    case 32:
    case 64:
    case 128:
    case 256:
    case 512:
    case 1024:
    case 2048:
    case 4096:
    case 8192:
    case 16384:
    case 32768:
    case 65536:
    case 131072:
    case 262144:
    case 524288:
    case 1048576:
    case 2097152:
      return t + 5e3;
    case 4194304:
    case 8388608:
    case 16777216:
    case 33554432:
    case 67108864:
      return -1;
    case 134217728:
    case 268435456:
    case 536870912:
    case 1073741824:
      return -1;
    default:
      return -1;
  }
}
function Yh(e, t) {
  for (
    var n = e.suspendedLanes,
      r = e.pingedLanes,
      i = e.expirationTimes,
      o = e.pendingLanes;
    0 < o;

  ) {
    var l = 31 - St(o),
      a = 1 << l,
      s = i[l];
    s === -1
      ? ((a & n) === 0 || (a & r) !== 0) && (i[l] = Gh(a, t))
      : s <= t && (e.expiredLanes |= a),
      (o &= ~a);
  }
}
function ss(e) {
  return (
    (e = e.pendingLanes & -1073741825),
    e !== 0 ? e : e & 1073741824 ? 1073741824 : 0
  );
}
function _f() {
  var e = yi;
  return (yi <<= 1), (yi & 4194240) === 0 && (yi = 64), e;
}
function fl(e) {
  for (var t = [], n = 0; 31 > n; n++) t.push(e);
  return t;
}
function ai(e, t, n) {
  (e.pendingLanes |= t),
    t !== 536870912 && ((e.suspendedLanes = 0), (e.pingedLanes = 0)),
    (e = e.eventTimes),
    (t = 31 - St(t)),
    (e[t] = n);
}
function Xh(e, t) {
  var n = e.pendingLanes & ~t;
  (e.pendingLanes = t),
    (e.suspendedLanes = 0),
    (e.pingedLanes = 0),
    (e.expiredLanes &= t),
    (e.mutableReadLanes &= t),
    (e.entangledLanes &= t),
    (t = e.entanglements);
  var r = e.eventTimes;
  for (e = e.expirationTimes; 0 < n; ) {
    var i = 31 - St(n),
      o = 1 << i;
    (t[i] = 0), (r[i] = -1), (e[i] = -1), (n &= ~o);
  }
}
function la(e, t) {
  var n = (e.entangledLanes |= t);
  for (e = e.entanglements; n; ) {
    var r = 31 - St(n),
      i = 1 << r;
    (i & t) | (e[r] & t) && (e[r] |= t), (n &= ~i);
  }
}
var oe = 0;
function Lf(e) {
  return (
    (e &= -e),
    1 < e ? (4 < e ? ((e & 268435455) !== 0 ? 16 : 536870912) : 4) : 1
  );
}
var Of,
  sa,
  Mf,
  Nf,
  Af,
  as = !1,
  wi = [],
  Yt = null,
  Xt = null,
  Qt = null,
  Wr = new Map(),
  Gr = new Map(),
  Bt = [],
  Qh =
    "mousedown mouseup touchcancel touchend touchstart auxclick dblclick pointercancel pointerdown pointerup dragend dragstart drop compositionend compositionstart keydown keypress keyup input textInput copy cut paste click change contextmenu reset submit".split(
      " "
    );
function wu(e, t) {
  switch (e) {
    case "focusin":
    case "focusout":
      Yt = null;
      break;
    case "dragenter":
    case "dragleave":
      Xt = null;
      break;
    case "mouseover":
    case "mouseout":
      Qt = null;
      break;
    case "pointerover":
    case "pointerout":
      Wr.delete(t.pointerId);
      break;
    case "gotpointercapture":
    case "lostpointercapture":
      Gr.delete(t.pointerId);
  }
}
function Sr(e, t, n, r, i, o) {
  return e === null || e.nativeEvent !== o
    ? ((e = {
        blockedOn: t,
        domEventName: n,
        eventSystemFlags: r,
        nativeEvent: o,
        targetContainers: [i],
      }),
      t !== null && ((t = ci(t)), t !== null && sa(t)),
      e)
    : ((e.eventSystemFlags |= r),
      (t = e.targetContainers),
      i !== null && t.indexOf(i) === -1 && t.push(i),
      e);
}
function Kh(e, t, n, r, i) {
  switch (t) {
    case "focusin":
      return (Yt = Sr(Yt, e, t, n, r, i)), !0;
    case "dragenter":
      return (Xt = Sr(Xt, e, t, n, r, i)), !0;
    case "mouseover":
      return (Qt = Sr(Qt, e, t, n, r, i)), !0;
    case "pointerover":
      var o = i.pointerId;
      return Wr.set(o, Sr(Wr.get(o) || null, e, t, n, r, i)), !0;
    case "gotpointercapture":
      return (
        (o = i.pointerId), Gr.set(o, Sr(Gr.get(o) || null, e, t, n, r, i)), !0
      );
  }
  return !1;
}
function zf(e) {
  var t = cn(e.target);
  if (t !== null) {
    var n = $n(t);
    if (n !== null) {
      if (((t = n.tag), t === 13)) {
        if (((t = Cf(n)), t !== null)) {
          (e.blockedOn = t),
            Af(e.priority, function () {
              Mf(n);
            });
          return;
        }
      } else if (t === 3 && n.stateNode.current.memoizedState.isDehydrated) {
        e.blockedOn = n.tag === 3 ? n.stateNode.containerInfo : null;
        return;
      }
    }
  }
  e.blockedOn = null;
}
function ji(e) {
  if (e.blockedOn !== null) return !1;
  for (var t = e.targetContainers; 0 < t.length; ) {
    var n = us(e.domEventName, e.eventSystemFlags, t[0], e.nativeEvent);
    if (n === null) {
      n = e.nativeEvent;
      var r = new n.constructor(n.type, n);
      (rs = r), n.target.dispatchEvent(r), (rs = null);
    } else return (t = ci(n)), t !== null && sa(t), (e.blockedOn = n), !1;
    t.shift();
  }
  return !0;
}
function xu(e, t, n) {
  ji(e) && n.delete(t);
}
function Zh() {
  (as = !1),
    Yt !== null && ji(Yt) && (Yt = null),
    Xt !== null && ji(Xt) && (Xt = null),
    Qt !== null && ji(Qt) && (Qt = null),
    Wr.forEach(xu),
    Gr.forEach(xu);
}
function wr(e, t) {
  e.blockedOn === t &&
    ((e.blockedOn = null),
    as ||
      ((as = !0),
      nt.unstable_scheduleCallback(nt.unstable_NormalPriority, Zh)));
}
function Yr(e) {
  function t(i) {
    return wr(i, e);
  }
  if (0 < wi.length) {
    wr(wi[0], e);
    for (var n = 1; n < wi.length; n++) {
      var r = wi[n];
      r.blockedOn === e && (r.blockedOn = null);
    }
  }
  for (
    Yt !== null && wr(Yt, e),
      Xt !== null && wr(Xt, e),
      Qt !== null && wr(Qt, e),
      Wr.forEach(t),
      Gr.forEach(t),
      n = 0;
    n < Bt.length;
    n++
  )
    (r = Bt[n]), r.blockedOn === e && (r.blockedOn = null);
  for (; 0 < Bt.length && ((n = Bt[0]), n.blockedOn === null); )
    zf(n), n.blockedOn === null && Bt.shift();
}
var Gn = It.ReactCurrentBatchConfig,
  no = !0;
function qh(e, t, n, r) {
  var i = oe,
    o = Gn.transition;
  Gn.transition = null;
  try {
    (oe = 1), aa(e, t, n, r);
  } finally {
    (oe = i), (Gn.transition = o);
  }
}
function Jh(e, t, n, r) {
  var i = oe,
    o = Gn.transition;
  Gn.transition = null;
  try {
    (oe = 4), aa(e, t, n, r);
  } finally {
    (oe = i), (Gn.transition = o);
  }
}
function aa(e, t, n, r) {
  if (no) {
    var i = us(e, t, n, r);
    if (i === null) xl(e, t, r, ro, n), wu(e, r);
    else if (Kh(i, e, t, n, r)) r.stopPropagation();
    else if ((wu(e, r), t & 4 && -1 < Qh.indexOf(e))) {
      for (; i !== null; ) {
        var o = ci(i);
        if (
          (o !== null && Of(o),
          (o = us(e, t, n, r)),
          o === null && xl(e, t, r, ro, n),
          o === i)
        )
          break;
        i = o;
      }
      i !== null && r.stopPropagation();
    } else xl(e, t, r, null, n);
  }
}
var ro = null;
function us(e, t, n, r) {
  if (((ro = null), (e = ia(r)), (e = cn(e)), e !== null))
    if (((t = $n(e)), t === null)) e = null;
    else if (((n = t.tag), n === 13)) {
      if (((e = Cf(t)), e !== null)) return e;
      e = null;
    } else if (n === 3) {
      if (t.stateNode.current.memoizedState.isDehydrated)
        return t.tag === 3 ? t.stateNode.containerInfo : null;
      e = null;
    } else t !== e && (e = null);
  return (ro = e), null;
}
function Rf(e) {
  switch (e) {
    case "cancel":
    case "click":
    case "close":
    case "contextmenu":
    case "copy":
    case "cut":
    case "auxclick":
    case "dblclick":
    case "dragend":
    case "dragstart":
    case "drop":
    case "focusin":
    case "focusout":
    case "input":
    case "invalid":
    case "keydown":
    case "keypress":
    case "keyup":
    case "mousedown":
    case "mouseup":
    case "paste":
    case "pause":
    case "play":
    case "pointercancel":
    case "pointerdown":
    case "pointerup":
    case "ratechange":
    case "reset":
    case "resize":
    case "seeked":
    case "submit":
    case "touchcancel":
    case "touchend":
    case "touchstart":
    case "volumechange":
    case "change":
    case "selectionchange":
    case "textInput":
    case "compositionstart":
    case "compositionend":
    case "compositionupdate":
    case "beforeblur":
    case "afterblur":
    case "beforeinput":
    case "blur":
    case "fullscreenchange":
    case "focus":
    case "hashchange":
    case "popstate":
    case "select":
    case "selectstart":
      return 1;
    case "drag":
    case "dragenter":
    case "dragexit":
    case "dragleave":
    case "dragover":
    case "mousemove":
    case "mouseout":
    case "mouseover":
    case "pointermove":
    case "pointerout":
    case "pointerover":
    case "scroll":
    case "toggle":
    case "touchmove":
    case "wheel":
    case "mouseenter":
    case "mouseleave":
    case "pointerenter":
    case "pointerleave":
      return 4;
    case "message":
      switch (Fh()) {
        case oa:
          return 1;
        case Pf:
          return 4;
        case eo:
        case Bh:
          return 16;
        case $f:
          return 536870912;
        default:
          return 16;
      }
    default:
      return 16;
  }
}
var Ht = null,
  ua = null,
  Fi = null;
function If() {
  if (Fi) return Fi;
  var e,
    t = ua,
    n = t.length,
    r,
    i = "value" in Ht ? Ht.value : Ht.textContent,
    o = i.length;
  for (e = 0; e < n && t[e] === i[e]; e++);
  var l = n - e;
  for (r = 1; r <= l && t[n - r] === i[o - r]; r++);
  return (Fi = i.slice(e, 1 < r ? 1 - r : void 0));
}
function Bi(e) {
  var t = e.keyCode;
  return (
    "charCode" in e
      ? ((e = e.charCode), e === 0 && t === 13 && (e = 13))
      : (e = t),
    e === 10 && (e = 13),
    32 <= e || e === 13 ? e : 0
  );
}
function xi() {
  return !0;
}
function Cu() {
  return !1;
}
function it(e) {
  function t(n, r, i, o, l) {
    (this._reactName = n),
      (this._targetInst = i),
      (this.type = r),
      (this.nativeEvent = o),
      (this.target = l),
      (this.currentTarget = null);
    for (var a in e)
      e.hasOwnProperty(a) && ((n = e[a]), (this[a] = n ? n(o) : o[a]));
    return (
      (this.isDefaultPrevented = (
        o.defaultPrevented != null ? o.defaultPrevented : o.returnValue === !1
      )
        ? xi
        : Cu),
      (this.isPropagationStopped = Cu),
      this
    );
  }
  return (
    he(t.prototype, {
      preventDefault: function () {
        this.defaultPrevented = !0;
        var n = this.nativeEvent;
        n &&
          (n.preventDefault
            ? n.preventDefault()
            : typeof n.returnValue != "unknown" && (n.returnValue = !1),
          (this.isDefaultPrevented = xi));
      },
      stopPropagation: function () {
        var n = this.nativeEvent;
        n &&
          (n.stopPropagation
            ? n.stopPropagation()
            : typeof n.cancelBubble != "unknown" && (n.cancelBubble = !0),
          (this.isPropagationStopped = xi));
      },
      persist: function () {},
      isPersistent: xi,
    }),
    t
  );
}
var cr = {
    eventPhase: 0,
    bubbles: 0,
    cancelable: 0,
    timeStamp: function (e) {
      return e.timeStamp || Date.now();
    },
    defaultPrevented: 0,
    isTrusted: 0,
  },
  ca = it(cr),
  ui = he({}, cr, { view: 0, detail: 0 }),
  em = it(ui),
  dl,
  pl,
  xr,
  Lo = he({}, ui, {
    screenX: 0,
    screenY: 0,
    clientX: 0,
    clientY: 0,
    pageX: 0,
    pageY: 0,
    ctrlKey: 0,
    shiftKey: 0,
    altKey: 0,
    metaKey: 0,
    getModifierState: fa,
    button: 0,
    buttons: 0,
    relatedTarget: function (e) {
      return e.relatedTarget === void 0
        ? e.fromElement === e.srcElement
          ? e.toElement
          : e.fromElement
        : e.relatedTarget;
    },
    movementX: function (e) {
      return "movementX" in e
        ? e.movementX
        : (e !== xr &&
            (xr && e.type === "mousemove"
              ? ((dl = e.screenX - xr.screenX), (pl = e.screenY - xr.screenY))
              : (pl = dl = 0),
            (xr = e)),
          dl);
    },
    movementY: function (e) {
      return "movementY" in e ? e.movementY : pl;
    },
  }),
  Eu = it(Lo),
  tm = he({}, Lo, { dataTransfer: 0 }),
  nm = it(tm),
  rm = he({}, ui, { relatedTarget: 0 }),
  hl = it(rm),
  im = he({}, cr, { animationName: 0, elapsedTime: 0, pseudoElement: 0 }),
  om = it(im),
  lm = he({}, cr, {
    clipboardData: function (e) {
      return "clipboardData" in e ? e.clipboardData : window.clipboardData;
    },
  }),
  sm = it(lm),
  am = he({}, cr, { data: 0 }),
  Tu = it(am),
  um = {
    Esc: "Escape",
    Spacebar: " ",
    Left: "ArrowLeft",
    Up: "ArrowUp",
    Right: "ArrowRight",
    Down: "ArrowDown",
    Del: "Delete",
    Win: "OS",
    Menu: "ContextMenu",
    Apps: "ContextMenu",
    Scroll: "ScrollLock",
    MozPrintableKey: "Unidentified",
  },
  cm = {
    8: "Backspace",
    9: "Tab",
    12: "Clear",
    13: "Enter",
    16: "Shift",
    17: "Control",
    18: "Alt",
    19: "Pause",
    20: "CapsLock",
    27: "Escape",
    32: " ",
    33: "PageUp",
    34: "PageDown",
    35: "End",
    36: "Home",
    37: "ArrowLeft",
    38: "ArrowUp",
    39: "ArrowRight",
    40: "ArrowDown",
    45: "Insert",
    46: "Delete",
    112: "F1",
    113: "F2",
    114: "F3",
    115: "F4",
    116: "F5",
    117: "F6",
    118: "F7",
    119: "F8",
    120: "F9",
    121: "F10",
    122: "F11",
    123: "F12",
    144: "NumLock",
    145: "ScrollLock",
    224: "Meta",
  },
  fm = {
    Alt: "altKey",
    Control: "ctrlKey",
    Meta: "metaKey",
    Shift: "shiftKey",
  };
function dm(e) {
  var t = this.nativeEvent;
  return t.getModifierState ? t.getModifierState(e) : (e = fm[e]) ? !!t[e] : !1;
}
function fa() {
  return dm;
}
var pm = he({}, ui, {
    key: function (e) {
      if (e.key) {
        var t = um[e.key] || e.key;
        if (t !== "Unidentified") return t;
      }
      return e.type === "keypress"
        ? ((e = Bi(e)), e === 13 ? "Enter" : String.fromCharCode(e))
        : e.type === "keydown" || e.type === "keyup"
        ? cm[e.keyCode] || "Unidentified"
        : "";
    },
    code: 0,
    location: 0,
    ctrlKey: 0,
    shiftKey: 0,
    altKey: 0,
    metaKey: 0,
    repeat: 0,
    locale: 0,
    getModifierState: fa,
    charCode: function (e) {
      return e.type === "keypress" ? Bi(e) : 0;
    },
    keyCode: function (e) {
      return e.type === "keydown" || e.type === "keyup" ? e.keyCode : 0;
    },
    which: function (e) {
      return e.type === "keypress"
        ? Bi(e)
        : e.type === "keydown" || e.type === "keyup"
        ? e.keyCode
        : 0;
    },
  }),
  hm = it(pm),
  mm = he({}, Lo, {
    pointerId: 0,
    width: 0,
    height: 0,
    pressure: 0,
    tangentialPressure: 0,
    tiltX: 0,
    tiltY: 0,
    twist: 0,
    pointerType: 0,
    isPrimary: 0,
  }),
  ku = it(mm),
  vm = he({}, ui, {
    touches: 0,
    targetTouches: 0,
    changedTouches: 0,
    altKey: 0,
    metaKey: 0,
    ctrlKey: 0,
    shiftKey: 0,
    getModifierState: fa,
  }),
  gm = it(vm),
  ym = he({}, cr, { propertyName: 0, elapsedTime: 0, pseudoElement: 0 }),
  Sm = it(ym),
  wm = he({}, Lo, {
    deltaX: function (e) {
      return "deltaX" in e ? e.deltaX : "wheelDeltaX" in e ? -e.wheelDeltaX : 0;
    },
    deltaY: function (e) {
      return "deltaY" in e
        ? e.deltaY
        : "wheelDeltaY" in e
        ? -e.wheelDeltaY
        : "wheelDelta" in e
        ? -e.wheelDelta
        : 0;
    },
    deltaZ: 0,
    deltaMode: 0,
  }),
  xm = it(wm),
  Cm = [9, 13, 27, 32],
  da = Nt && "CompositionEvent" in window,
  Nr = null;
Nt && "documentMode" in document && (Nr = document.documentMode);
var Em = Nt && "TextEvent" in window && !Nr,
  bf = Nt && (!da || (Nr && 8 < Nr && 11 >= Nr)),
  Pu = String.fromCharCode(32),
  $u = !1;
function Df(e, t) {
  switch (e) {
    case "keyup":
      return Cm.indexOf(t.keyCode) !== -1;
    case "keydown":
      return t.keyCode !== 229;
    case "keypress":
    case "mousedown":
    case "focusout":
      return !0;
    default:
      return !1;
  }
}
function jf(e) {
  return (e = e.detail), typeof e == "object" && "data" in e ? e.data : null;
}
var Nn = !1;
function Tm(e, t) {
  switch (e) {
    case "compositionend":
      return jf(t);
    case "keypress":
      return t.which !== 32 ? null : (($u = !0), Pu);
    case "textInput":
      return (e = t.data), e === Pu && $u ? null : e;
    default:
      return null;
  }
}
function km(e, t) {
  if (Nn)
    return e === "compositionend" || (!da && Df(e, t))
      ? ((e = If()), (Fi = ua = Ht = null), (Nn = !1), e)
      : null;
  switch (e) {
    case "paste":
      return null;
    case "keypress":
      if (!(t.ctrlKey || t.altKey || t.metaKey) || (t.ctrlKey && t.altKey)) {
        if (t.char && 1 < t.char.length) return t.char;
        if (t.which) return String.fromCharCode(t.which);
      }
      return null;
    case "compositionend":
      return bf && t.locale !== "ko" ? null : t.data;
    default:
      return null;
  }
}
var Pm = {
  color: !0,
  date: !0,
  datetime: !0,
  "datetime-local": !0,
  email: !0,
  month: !0,
  number: !0,
  password: !0,
  range: !0,
  search: !0,
  tel: !0,
  text: !0,
  time: !0,
  url: !0,
  week: !0,
};
function _u(e) {
  var t = e && e.nodeName && e.nodeName.toLowerCase();
  return t === "input" ? !!Pm[e.type] : t === "textarea";
}
function Ff(e, t, n, r) {
  gf(r),
    (t = io(t, "onChange")),
    0 < t.length &&
      ((n = new ca("onChange", "change", null, n, r)),
      e.push({ event: n, listeners: t }));
}
var Ar = null,
  Xr = null;
function $m(e) {
  Zf(e, 0);
}
function Oo(e) {
  var t = Rn(e);
  if (cf(t)) return e;
}
function _m(e, t) {
  if (e === "change") return t;
}
var Bf = !1;
if (Nt) {
  var ml;
  if (Nt) {
    var vl = "oninput" in document;
    if (!vl) {
      var Lu = document.createElement("div");
      Lu.setAttribute("oninput", "return;"),
        (vl = typeof Lu.oninput == "function");
    }
    ml = vl;
  } else ml = !1;
  Bf = ml && (!document.documentMode || 9 < document.documentMode);
}
function Ou() {
  Ar && (Ar.detachEvent("onpropertychange", Vf), (Xr = Ar = null));
}
function Vf(e) {
  if (e.propertyName === "value" && Oo(Xr)) {
    var t = [];
    Ff(t, Xr, e, ia(e)), xf($m, t);
  }
}
function Lm(e, t, n) {
  e === "focusin"
    ? (Ou(), (Ar = t), (Xr = n), Ar.attachEvent("onpropertychange", Vf))
    : e === "focusout" && Ou();
}
function Om(e) {
  if (e === "selectionchange" || e === "keyup" || e === "keydown")
    return Oo(Xr);
}
function Mm(e, t) {
  if (e === "click") return Oo(t);
}
function Nm(e, t) {
  if (e === "input" || e === "change") return Oo(t);
}
function Am(e, t) {
  return (e === t && (e !== 0 || 1 / e === 1 / t)) || (e !== e && t !== t);
}
var xt = typeof Object.is == "function" ? Object.is : Am;
function Qr(e, t) {
  if (xt(e, t)) return !0;
  if (typeof e != "object" || e === null || typeof t != "object" || t === null)
    return !1;
  var n = Object.keys(e),
    r = Object.keys(t);
  if (n.length !== r.length) return !1;
  for (r = 0; r < n.length; r++) {
    var i = n[r];
    if (!Wl.call(t, i) || !xt(e[i], t[i])) return !1;
  }
  return !0;
}
function Mu(e) {
  for (; e && e.firstChild; ) e = e.firstChild;
  return e;
}
function Nu(e, t) {
  var n = Mu(e);
  e = 0;
  for (var r; n; ) {
    if (n.nodeType === 3) {
      if (((r = e + n.textContent.length), e <= t && r >= t))
        return { node: n, offset: t - e };
      e = r;
    }
    e: {
      for (; n; ) {
        if (n.nextSibling) {
          n = n.nextSibling;
          break e;
        }
        n = n.parentNode;
      }
      n = void 0;
    }
    n = Mu(n);
  }
}
function Hf(e, t) {
  return e && t
    ? e === t
      ? !0
      : e && e.nodeType === 3
      ? !1
      : t && t.nodeType === 3
      ? Hf(e, t.parentNode)
      : "contains" in e
      ? e.contains(t)
      : e.compareDocumentPosition
      ? !!(e.compareDocumentPosition(t) & 16)
      : !1
    : !1;
}
function Uf() {
  for (var e = window, t = Zi(); t instanceof e.HTMLIFrameElement; ) {
    try {
      var n = typeof t.contentWindow.location.href == "string";
    } catch {
      n = !1;
    }
    if (n) e = t.contentWindow;
    else break;
    t = Zi(e.document);
  }
  return t;
}
function pa(e) {
  var t = e && e.nodeName && e.nodeName.toLowerCase();
  return (
    t &&
    ((t === "input" &&
      (e.type === "text" ||
        e.type === "search" ||
        e.type === "tel" ||
        e.type === "url" ||
        e.type === "password")) ||
      t === "textarea" ||
      e.contentEditable === "true")
  );
}
function zm(e) {
  var t = Uf(),
    n = e.focusedElem,
    r = e.selectionRange;
  if (
    t !== n &&
    n &&
    n.ownerDocument &&
    Hf(n.ownerDocument.documentElement, n)
  ) {
    if (r !== null && pa(n)) {
      if (
        ((t = r.start),
        (e = r.end),
        e === void 0 && (e = t),
        "selectionStart" in n)
      )
        (n.selectionStart = t), (n.selectionEnd = Math.min(e, n.value.length));
      else if (
        ((e = ((t = n.ownerDocument || document) && t.defaultView) || window),
        e.getSelection)
      ) {
        e = e.getSelection();
        var i = n.textContent.length,
          o = Math.min(r.start, i);
        (r = r.end === void 0 ? o : Math.min(r.end, i)),
          !e.extend && o > r && ((i = r), (r = o), (o = i)),
          (i = Nu(n, o));
        var l = Nu(n, r);
        i &&
          l &&
          (e.rangeCount !== 1 ||
            e.anchorNode !== i.node ||
            e.anchorOffset !== i.offset ||
            e.focusNode !== l.node ||
            e.focusOffset !== l.offset) &&
          ((t = t.createRange()),
          t.setStart(i.node, i.offset),
          e.removeAllRanges(),
          o > r
            ? (e.addRange(t), e.extend(l.node, l.offset))
            : (t.setEnd(l.node, l.offset), e.addRange(t)));
      }
    }
    for (t = [], e = n; (e = e.parentNode); )
      e.nodeType === 1 &&
        t.push({ element: e, left: e.scrollLeft, top: e.scrollTop });
    for (typeof n.focus == "function" && n.focus(), n = 0; n < t.length; n++)
      (e = t[n]),
        (e.element.scrollLeft = e.left),
        (e.element.scrollTop = e.top);
  }
}
var Rm = Nt && "documentMode" in document && 11 >= document.documentMode,
  An = null,
  cs = null,
  zr = null,
  fs = !1;
function Au(e, t, n) {
  var r = n.window === n ? n.document : n.nodeType === 9 ? n : n.ownerDocument;
  fs ||
    An == null ||
    An !== Zi(r) ||
    ((r = An),
    "selectionStart" in r && pa(r)
      ? (r = { start: r.selectionStart, end: r.selectionEnd })
      : ((r = (
          (r.ownerDocument && r.ownerDocument.defaultView) ||
          window
        ).getSelection()),
        (r = {
          anchorNode: r.anchorNode,
          anchorOffset: r.anchorOffset,
          focusNode: r.focusNode,
          focusOffset: r.focusOffset,
        })),
    (zr && Qr(zr, r)) ||
      ((zr = r),
      (r = io(cs, "onSelect")),
      0 < r.length &&
        ((t = new ca("onSelect", "select", null, t, n)),
        e.push({ event: t, listeners: r }),
        (t.target = An))));
}
function Ci(e, t) {
  var n = {};
  return (
    (n[e.toLowerCase()] = t.toLowerCase()),
    (n["Webkit" + e] = "webkit" + t),
    (n["Moz" + e] = "moz" + t),
    n
  );
}
var zn = {
    animationend: Ci("Animation", "AnimationEnd"),
    animationiteration: Ci("Animation", "AnimationIteration"),
    animationstart: Ci("Animation", "AnimationStart"),
    transitionend: Ci("Transition", "TransitionEnd"),
  },
  gl = {},
  Wf = {};
Nt &&
  ((Wf = document.createElement("div").style),
  "AnimationEvent" in window ||
    (delete zn.animationend.animation,
    delete zn.animationiteration.animation,
    delete zn.animationstart.animation),
  "TransitionEvent" in window || delete zn.transitionend.transition);
function Mo(e) {
  if (gl[e]) return gl[e];
  if (!zn[e]) return e;
  var t = zn[e],
    n;
  for (n in t) if (t.hasOwnProperty(n) && n in Wf) return (gl[e] = t[n]);
  return e;
}
var Gf = Mo("animationend"),
  Yf = Mo("animationiteration"),
  Xf = Mo("animationstart"),
  Qf = Mo("transitionend"),
  Kf = new Map(),
  zu =
    "abort auxClick cancel canPlay canPlayThrough click close contextMenu copy cut drag dragEnd dragEnter dragExit dragLeave dragOver dragStart drop durationChange emptied encrypted ended error gotPointerCapture input invalid keyDown keyPress keyUp load loadedData loadedMetadata loadStart lostPointerCapture mouseDown mouseMove mouseOut mouseOver mouseUp paste pause play playing pointerCancel pointerDown pointerMove pointerOut pointerOver pointerUp progress rateChange reset resize seeked seeking stalled submit suspend timeUpdate touchCancel touchEnd touchStart volumeChange scroll toggle touchMove waiting wheel".split(
      " "
    );
function on(e, t) {
  Kf.set(e, t), Pn(t, [e]);
}
for (var yl = 0; yl < zu.length; yl++) {
  var Sl = zu[yl],
    Im = Sl.toLowerCase(),
    bm = Sl[0].toUpperCase() + Sl.slice(1);
  on(Im, "on" + bm);
}
on(Gf, "onAnimationEnd");
on(Yf, "onAnimationIteration");
on(Xf, "onAnimationStart");
on("dblclick", "onDoubleClick");
on("focusin", "onFocus");
on("focusout", "onBlur");
on(Qf, "onTransitionEnd");
Qn("onMouseEnter", ["mouseout", "mouseover"]);
Qn("onMouseLeave", ["mouseout", "mouseover"]);
Qn("onPointerEnter", ["pointerout", "pointerover"]);
Qn("onPointerLeave", ["pointerout", "pointerover"]);
Pn(
  "onChange",
  "change click focusin focusout input keydown keyup selectionchange".split(" ")
);
Pn(
  "onSelect",
  "focusout contextmenu dragend focusin keydown keyup mousedown mouseup selectionchange".split(
    " "
  )
);
Pn("onBeforeInput", ["compositionend", "keypress", "textInput", "paste"]);
Pn(
  "onCompositionEnd",
  "compositionend focusout keydown keypress keyup mousedown".split(" ")
);
Pn(
  "onCompositionStart",
  "compositionstart focusout keydown keypress keyup mousedown".split(" ")
);
Pn(
  "onCompositionUpdate",
  "compositionupdate focusout keydown keypress keyup mousedown".split(" ")
);
var Lr =
    "abort canplay canplaythrough durationchange emptied encrypted ended error loadeddata loadedmetadata loadstart pause play playing progress ratechange resize seeked seeking stalled suspend timeupdate volumechange waiting".split(
      " "
    ),
  Dm = new Set("cancel close invalid load scroll toggle".split(" ").concat(Lr));
function Ru(e, t, n) {
  var r = e.type || "unknown-event";
  (e.currentTarget = n), Ih(r, t, void 0, e), (e.currentTarget = null);
}
function Zf(e, t) {
  t = (t & 4) !== 0;
  for (var n = 0; n < e.length; n++) {
    var r = e[n],
      i = r.event;
    r = r.listeners;
    e: {
      var o = void 0;
      if (t)
        for (var l = r.length - 1; 0 <= l; l--) {
          var a = r[l],
            s = a.instance,
            u = a.currentTarget;
          if (((a = a.listener), s !== o && i.isPropagationStopped())) break e;
          Ru(i, a, u), (o = s);
        }
      else
        for (l = 0; l < r.length; l++) {
          if (
            ((a = r[l]),
            (s = a.instance),
            (u = a.currentTarget),
            (a = a.listener),
            s !== o && i.isPropagationStopped())
          )
            break e;
          Ru(i, a, u), (o = s);
        }
    }
  }
  if (Ji) throw ((e = ls), (Ji = !1), (ls = null), e);
}
function ue(e, t) {
  var n = t[vs];
  n === void 0 && (n = t[vs] = new Set());
  var r = e + "__bubble";
  n.has(r) || (qf(t, e, 2, !1), n.add(r));
}
function wl(e, t, n) {
  var r = 0;
  t && (r |= 4), qf(n, e, r, t);
}
var Ei = "_reactListening" + Math.random().toString(36).slice(2);
function Kr(e) {
  if (!e[Ei]) {
    (e[Ei] = !0),
      of.forEach(function (n) {
        n !== "selectionchange" && (Dm.has(n) || wl(n, !1, e), wl(n, !0, e));
      });
    var t = e.nodeType === 9 ? e : e.ownerDocument;
    t === null || t[Ei] || ((t[Ei] = !0), wl("selectionchange", !1, t));
  }
}
function qf(e, t, n, r) {
  switch (Rf(t)) {
    case 1:
      var i = qh;
      break;
    case 4:
      i = Jh;
      break;
    default:
      i = aa;
  }
  (n = i.bind(null, t, n, e)),
    (i = void 0),
    !os ||
      (t !== "touchstart" && t !== "touchmove" && t !== "wheel") ||
      (i = !0),
    r
      ? i !== void 0
        ? e.addEventListener(t, n, { capture: !0, passive: i })
        : e.addEventListener(t, n, !0)
      : i !== void 0
      ? e.addEventListener(t, n, { passive: i })
      : e.addEventListener(t, n, !1);
}
function xl(e, t, n, r, i) {
  var o = r;
  if ((t & 1) === 0 && (t & 2) === 0 && r !== null)
    e: for (;;) {
      if (r === null) return;
      var l = r.tag;
      if (l === 3 || l === 4) {
        var a = r.stateNode.containerInfo;
        if (a === i || (a.nodeType === 8 && a.parentNode === i)) break;
        if (l === 4)
          for (l = r.return; l !== null; ) {
            var s = l.tag;
            if (
              (s === 3 || s === 4) &&
              ((s = l.stateNode.containerInfo),
              s === i || (s.nodeType === 8 && s.parentNode === i))
            )
              return;
            l = l.return;
          }
        for (; a !== null; ) {
          if (((l = cn(a)), l === null)) return;
          if (((s = l.tag), s === 5 || s === 6)) {
            r = o = l;
            continue e;
          }
          a = a.parentNode;
        }
      }
      r = r.return;
    }
  xf(function () {
    var u = o,
      c = ia(n),
      f = [];
    e: {
      var d = Kf.get(e);
      if (d !== void 0) {
        var v = ca,
          g = e;
        switch (e) {
          case "keypress":
            if (Bi(n) === 0) break e;
          case "keydown":
          case "keyup":
            v = hm;
            break;
          case "focusin":
            (g = "focus"), (v = hl);
            break;
          case "focusout":
            (g = "blur"), (v = hl);
            break;
          case "beforeblur":
          case "afterblur":
            v = hl;
            break;
          case "click":
            if (n.button === 2) break e;
          case "auxclick":
          case "dblclick":
          case "mousedown":
          case "mousemove":
          case "mouseup":
          case "mouseout":
          case "mouseover":
          case "contextmenu":
            v = Eu;
            break;
          case "drag":
          case "dragend":
          case "dragenter":
          case "dragexit":
          case "dragleave":
          case "dragover":
          case "dragstart":
          case "drop":
            v = nm;
            break;
          case "touchcancel":
          case "touchend":
          case "touchmove":
          case "touchstart":
            v = gm;
            break;
          case Gf:
          case Yf:
          case Xf:
            v = om;
            break;
          case Qf:
            v = Sm;
            break;
          case "scroll":
            v = em;
            break;
          case "wheel":
            v = xm;
            break;
          case "copy":
          case "cut":
          case "paste":
            v = sm;
            break;
          case "gotpointercapture":
          case "lostpointercapture":
          case "pointercancel":
          case "pointerdown":
          case "pointermove":
          case "pointerout":
          case "pointerover":
          case "pointerup":
            v = ku;
        }
        var y = (t & 4) !== 0,
          x = !y && e === "scroll",
          h = y ? (d !== null ? d + "Capture" : null) : d;
        y = [];
        for (var p = u, m; p !== null; ) {
          m = p;
          var S = m.stateNode;
          if (
            (m.tag === 5 &&
              S !== null &&
              ((m = S),
              h !== null && ((S = Ur(p, h)), S != null && y.push(Zr(p, S, m)))),
            x)
          )
            break;
          p = p.return;
        }
        0 < y.length &&
          ((d = new v(d, g, null, n, c)), f.push({ event: d, listeners: y }));
      }
    }
    if ((t & 7) === 0) {
      e: {
        if (
          ((d = e === "mouseover" || e === "pointerover"),
          (v = e === "mouseout" || e === "pointerout"),
          d &&
            n !== rs &&
            (g = n.relatedTarget || n.fromElement) &&
            (cn(g) || g[At]))
        )
          break e;
        if (
          (v || d) &&
          ((d =
            c.window === c
              ? c
              : (d = c.ownerDocument)
              ? d.defaultView || d.parentWindow
              : window),
          v
            ? ((g = n.relatedTarget || n.toElement),
              (v = u),
              (g = g ? cn(g) : null),
              g !== null &&
                ((x = $n(g)), g !== x || (g.tag !== 5 && g.tag !== 6)) &&
                (g = null))
            : ((v = null), (g = u)),
          v !== g)
        ) {
          if (
            ((y = Eu),
            (S = "onMouseLeave"),
            (h = "onMouseEnter"),
            (p = "mouse"),
            (e === "pointerout" || e === "pointerover") &&
              ((y = ku),
              (S = "onPointerLeave"),
              (h = "onPointerEnter"),
              (p = "pointer")),
            (x = v == null ? d : Rn(v)),
            (m = g == null ? d : Rn(g)),
            (d = new y(S, p + "leave", v, n, c)),
            (d.target = x),
            (d.relatedTarget = m),
            (S = null),
            cn(c) === u &&
              ((y = new y(h, p + "enter", g, n, c)),
              (y.target = m),
              (y.relatedTarget = x),
              (S = y)),
            (x = S),
            v && g)
          )
            t: {
              for (y = v, h = g, p = 0, m = y; m; m = Ln(m)) p++;
              for (m = 0, S = h; S; S = Ln(S)) m++;
              for (; 0 < p - m; ) (y = Ln(y)), p--;
              for (; 0 < m - p; ) (h = Ln(h)), m--;
              for (; p--; ) {
                if (y === h || (h !== null && y === h.alternate)) break t;
                (y = Ln(y)), (h = Ln(h));
              }
              y = null;
            }
          else y = null;
          v !== null && Iu(f, d, v, y, !1),
            g !== null && x !== null && Iu(f, x, g, y, !0);
        }
      }
      e: {
        if (
          ((d = u ? Rn(u) : window),
          (v = d.nodeName && d.nodeName.toLowerCase()),
          v === "select" || (v === "input" && d.type === "file"))
        )
          var w = _m;
        else if (_u(d))
          if (Bf) w = Nm;
          else {
            w = Om;
            var P = Lm;
          }
        else
          (v = d.nodeName) &&
            v.toLowerCase() === "input" &&
            (d.type === "checkbox" || d.type === "radio") &&
            (w = Mm);
        if (w && (w = w(e, u))) {
          Ff(f, w, n, c);
          break e;
        }
        P && P(e, d, u),
          e === "focusout" &&
            (P = d._wrapperState) &&
            P.controlled &&
            d.type === "number" &&
            ql(d, "number", d.value);
      }
      switch (((P = u ? Rn(u) : window), e)) {
        case "focusin":
          (_u(P) || P.contentEditable === "true") &&
            ((An = P), (cs = u), (zr = null));
          break;
        case "focusout":
          zr = cs = An = null;
          break;
        case "mousedown":
          fs = !0;
          break;
        case "contextmenu":
        case "mouseup":
        case "dragend":
          (fs = !1), Au(f, n, c);
          break;
        case "selectionchange":
          if (Rm) break;
        case "keydown":
        case "keyup":
          Au(f, n, c);
      }
      var E;
      if (da)
        e: {
          switch (e) {
            case "compositionstart":
              var k = "onCompositionStart";
              break e;
            case "compositionend":
              k = "onCompositionEnd";
              break e;
            case "compositionupdate":
              k = "onCompositionUpdate";
              break e;
          }
          k = void 0;
        }
      else
        Nn
          ? Df(e, n) && (k = "onCompositionEnd")
          : e === "keydown" && n.keyCode === 229 && (k = "onCompositionStart");
      k &&
        (bf &&
          n.locale !== "ko" &&
          (Nn || k !== "onCompositionStart"
            ? k === "onCompositionEnd" && Nn && (E = If())
            : ((Ht = c),
              (ua = "value" in Ht ? Ht.value : Ht.textContent),
              (Nn = !0))),
        (P = io(u, k)),
        0 < P.length &&
          ((k = new Tu(k, e, null, n, c)),
          f.push({ event: k, listeners: P }),
          E ? (k.data = E) : ((E = jf(n)), E !== null && (k.data = E)))),
        (E = Em ? Tm(e, n) : km(e, n)) &&
          ((u = io(u, "onBeforeInput")),
          0 < u.length &&
            ((c = new Tu("onBeforeInput", "beforeinput", null, n, c)),
            f.push({ event: c, listeners: u }),
            (c.data = E)));
    }
    Zf(f, t);
  });
}
function Zr(e, t, n) {
  return { instance: e, listener: t, currentTarget: n };
}
function io(e, t) {
  for (var n = t + "Capture", r = []; e !== null; ) {
    var i = e,
      o = i.stateNode;
    i.tag === 5 &&
      o !== null &&
      ((i = o),
      (o = Ur(e, n)),
      o != null && r.unshift(Zr(e, o, i)),
      (o = Ur(e, t)),
      o != null && r.push(Zr(e, o, i))),
      (e = e.return);
  }
  return r;
}
function Ln(e) {
  if (e === null) return null;
  do e = e.return;
  while (e && e.tag !== 5);
  return e || null;
}
function Iu(e, t, n, r, i) {
  for (var o = t._reactName, l = []; n !== null && n !== r; ) {
    var a = n,
      s = a.alternate,
      u = a.stateNode;
    if (s !== null && s === r) break;
    a.tag === 5 &&
      u !== null &&
      ((a = u),
      i
        ? ((s = Ur(n, o)), s != null && l.unshift(Zr(n, s, a)))
        : i || ((s = Ur(n, o)), s != null && l.push(Zr(n, s, a)))),
      (n = n.return);
  }
  l.length !== 0 && e.push({ event: t, listeners: l });
}
var jm = /\r\n?/g,
  Fm = /\u0000|\uFFFD/g;
function bu(e) {
  return (typeof e == "string" ? e : "" + e)
    .replace(
      jm,
      `
`
    )
    .replace(Fm, "");
}
function Ti(e, t, n) {
  if (((t = bu(t)), bu(e) !== t && n)) throw Error(R(425));
}
function oo() {}
var ds = null,
  ps = null;
function hs(e, t) {
  return (
    e === "textarea" ||
    e === "noscript" ||
    typeof t.children == "string" ||
    typeof t.children == "number" ||
    (typeof t.dangerouslySetInnerHTML == "object" &&
      t.dangerouslySetInnerHTML !== null &&
      t.dangerouslySetInnerHTML.__html != null)
  );
}
var ms = typeof setTimeout == "function" ? setTimeout : void 0,
  Bm = typeof clearTimeout == "function" ? clearTimeout : void 0,
  Du = typeof Promise == "function" ? Promise : void 0,
  Vm =
    typeof queueMicrotask == "function"
      ? queueMicrotask
      : typeof Du != "undefined"
      ? function (e) {
          return Du.resolve(null).then(e).catch(Hm);
        }
      : ms;
function Hm(e) {
  setTimeout(function () {
    throw e;
  });
}
function Cl(e, t) {
  var n = t,
    r = 0;
  do {
    var i = n.nextSibling;
    if ((e.removeChild(n), i && i.nodeType === 8))
      if (((n = i.data), n === "/$")) {
        if (r === 0) {
          e.removeChild(i), Yr(t);
          return;
        }
        r--;
      } else (n !== "$" && n !== "$?" && n !== "$!") || r++;
    n = i;
  } while (n);
  Yr(t);
}
function Kt(e) {
  for (; e != null; e = e.nextSibling) {
    var t = e.nodeType;
    if (t === 1 || t === 3) break;
    if (t === 8) {
      if (((t = e.data), t === "$" || t === "$!" || t === "$?")) break;
      if (t === "/$") return null;
    }
  }
  return e;
}
function ju(e) {
  e = e.previousSibling;
  for (var t = 0; e; ) {
    if (e.nodeType === 8) {
      var n = e.data;
      if (n === "$" || n === "$!" || n === "$?") {
        if (t === 0) return e;
        t--;
      } else n === "/$" && t++;
    }
    e = e.previousSibling;
  }
  return null;
}
var fr = Math.random().toString(36).slice(2),
  Tt = "__reactFiber$" + fr,
  qr = "__reactProps$" + fr,
  At = "__reactContainer$" + fr,
  vs = "__reactEvents$" + fr,
  Um = "__reactListeners$" + fr,
  Wm = "__reactHandles$" + fr;
function cn(e) {
  var t = e[Tt];
  if (t) return t;
  for (var n = e.parentNode; n; ) {
    if ((t = n[At] || n[Tt])) {
      if (
        ((n = t.alternate),
        t.child !== null || (n !== null && n.child !== null))
      )
        for (e = ju(e); e !== null; ) {
          if ((n = e[Tt])) return n;
          e = ju(e);
        }
      return t;
    }
    (e = n), (n = e.parentNode);
  }
  return null;
}
function ci(e) {
  return (
    (e = e[Tt] || e[At]),
    !e || (e.tag !== 5 && e.tag !== 6 && e.tag !== 13 && e.tag !== 3) ? null : e
  );
}
function Rn(e) {
  if (e.tag === 5 || e.tag === 6) return e.stateNode;
  throw Error(R(33));
}
function No(e) {
  return e[qr] || null;
}
var gs = [],
  In = -1;
function ln(e) {
  return { current: e };
}
function ce(e) {
  0 > In || ((e.current = gs[In]), (gs[In] = null), In--);
}
function se(e, t) {
  In++, (gs[In] = e.current), (e.current = t);
}
var rn = {},
  be = ln(rn),
  Ye = ln(!1),
  vn = rn;
function Kn(e, t) {
  var n = e.type.contextTypes;
  if (!n) return rn;
  var r = e.stateNode;
  if (r && r.__reactInternalMemoizedUnmaskedChildContext === t)
    return r.__reactInternalMemoizedMaskedChildContext;
  var i = {},
    o;
  for (o in n) i[o] = t[o];
  return (
    r &&
      ((e = e.stateNode),
      (e.__reactInternalMemoizedUnmaskedChildContext = t),
      (e.__reactInternalMemoizedMaskedChildContext = i)),
    i
  );
}
function Xe(e) {
  return (e = e.childContextTypes), e != null;
}
function lo() {
  ce(Ye), ce(be);
}
function Fu(e, t, n) {
  if (be.current !== rn) throw Error(R(168));
  se(be, t), se(Ye, n);
}
function Jf(e, t, n) {
  var r = e.stateNode;
  if (((t = t.childContextTypes), typeof r.getChildContext != "function"))
    return n;
  r = r.getChildContext();
  for (var i in r) if (!(i in t)) throw Error(R(108, Lh(e) || "Unknown", i));
  return he({}, n, r);
}
function so(e) {
  return (
    (e =
      ((e = e.stateNode) && e.__reactInternalMemoizedMergedChildContext) || rn),
    (vn = be.current),
    se(be, e),
    se(Ye, Ye.current),
    !0
  );
}
function Bu(e, t, n) {
  var r = e.stateNode;
  if (!r) throw Error(R(169));
  n
    ? ((e = Jf(e, t, vn)),
      (r.__reactInternalMemoizedMergedChildContext = e),
      ce(Ye),
      ce(be),
      se(be, e))
    : ce(Ye),
    se(Ye, n);
}
var _t = null,
  Ao = !1,
  El = !1;
function ed(e) {
  _t === null ? (_t = [e]) : _t.push(e);
}
function Gm(e) {
  (Ao = !0), ed(e);
}
function sn() {
  if (!El && _t !== null) {
    El = !0;
    var e = 0,
      t = oe;
    try {
      var n = _t;
      for (oe = 1; e < n.length; e++) {
        var r = n[e];
        do r = r(!0);
        while (r !== null);
      }
      (_t = null), (Ao = !1);
    } catch (i) {
      throw (_t !== null && (_t = _t.slice(e + 1)), kf(oa, sn), i);
    } finally {
      (oe = t), (El = !1);
    }
  }
  return null;
}
var bn = [],
  Dn = 0,
  ao = null,
  uo = 0,
  st = [],
  at = 0,
  gn = null,
  Lt = 1,
  Ot = "";
function an(e, t) {
  (bn[Dn++] = uo), (bn[Dn++] = ao), (ao = e), (uo = t);
}
function td(e, t, n) {
  (st[at++] = Lt), (st[at++] = Ot), (st[at++] = gn), (gn = e);
  var r = Lt;
  e = Ot;
  var i = 32 - St(r) - 1;
  (r &= ~(1 << i)), (n += 1);
  var o = 32 - St(t) + i;
  if (30 < o) {
    var l = i - (i % 5);
    (o = (r & ((1 << l) - 1)).toString(32)),
      (r >>= l),
      (i -= l),
      (Lt = (1 << (32 - St(t) + i)) | (n << i) | r),
      (Ot = o + e);
  } else (Lt = (1 << o) | (n << i) | r), (Ot = e);
}
function ha(e) {
  e.return !== null && (an(e, 1), td(e, 1, 0));
}
function ma(e) {
  for (; e === ao; )
    (ao = bn[--Dn]), (bn[Dn] = null), (uo = bn[--Dn]), (bn[Dn] = null);
  for (; e === gn; )
    (gn = st[--at]),
      (st[at] = null),
      (Ot = st[--at]),
      (st[at] = null),
      (Lt = st[--at]),
      (st[at] = null);
}
var tt = null,
  Je = null,
  fe = !1,
  gt = null;
function nd(e, t) {
  var n = ut(5, null, null, 0);
  (n.elementType = "DELETED"),
    (n.stateNode = t),
    (n.return = e),
    (t = e.deletions),
    t === null ? ((e.deletions = [n]), (e.flags |= 16)) : t.push(n);
}
function Vu(e, t) {
  switch (e.tag) {
    case 5:
      var n = e.type;
      return (
        (t =
          t.nodeType !== 1 || n.toLowerCase() !== t.nodeName.toLowerCase()
            ? null
            : t),
        t !== null
          ? ((e.stateNode = t), (tt = e), (Je = Kt(t.firstChild)), !0)
          : !1
      );
    case 6:
      return (
        (t = e.pendingProps === "" || t.nodeType !== 3 ? null : t),
        t !== null ? ((e.stateNode = t), (tt = e), (Je = null), !0) : !1
      );
    case 13:
      return (
        (t = t.nodeType !== 8 ? null : t),
        t !== null
          ? ((n = gn !== null ? { id: Lt, overflow: Ot } : null),
            (e.memoizedState = {
              dehydrated: t,
              treeContext: n,
              retryLane: 1073741824,
            }),
            (n = ut(18, null, null, 0)),
            (n.stateNode = t),
            (n.return = e),
            (e.child = n),
            (tt = e),
            (Je = null),
            !0)
          : !1
      );
    default:
      return !1;
  }
}
function ys(e) {
  return (e.mode & 1) !== 0 && (e.flags & 128) === 0;
}
function Ss(e) {
  if (fe) {
    var t = Je;
    if (t) {
      var n = t;
      if (!Vu(e, t)) {
        if (ys(e)) throw Error(R(418));
        t = Kt(n.nextSibling);
        var r = tt;
        t && Vu(e, t)
          ? nd(r, n)
          : ((e.flags = (e.flags & -4097) | 2), (fe = !1), (tt = e));
      }
    } else {
      if (ys(e)) throw Error(R(418));
      (e.flags = (e.flags & -4097) | 2), (fe = !1), (tt = e);
    }
  }
}
function Hu(e) {
  for (e = e.return; e !== null && e.tag !== 5 && e.tag !== 3 && e.tag !== 13; )
    e = e.return;
  tt = e;
}
function ki(e) {
  if (e !== tt) return !1;
  if (!fe) return Hu(e), (fe = !0), !1;
  var t;
  if (
    ((t = e.tag !== 3) &&
      !(t = e.tag !== 5) &&
      ((t = e.type),
      (t = t !== "head" && t !== "body" && !hs(e.type, e.memoizedProps))),
    t && (t = Je))
  ) {
    if (ys(e)) throw (rd(), Error(R(418)));
    for (; t; ) nd(e, t), (t = Kt(t.nextSibling));
  }
  if ((Hu(e), e.tag === 13)) {
    if (((e = e.memoizedState), (e = e !== null ? e.dehydrated : null), !e))
      throw Error(R(317));
    e: {
      for (e = e.nextSibling, t = 0; e; ) {
        if (e.nodeType === 8) {
          var n = e.data;
          if (n === "/$") {
            if (t === 0) {
              Je = Kt(e.nextSibling);
              break e;
            }
            t--;
          } else (n !== "$" && n !== "$!" && n !== "$?") || t++;
        }
        e = e.nextSibling;
      }
      Je = null;
    }
  } else Je = tt ? Kt(e.stateNode.nextSibling) : null;
  return !0;
}
function rd() {
  for (var e = Je; e; ) e = Kt(e.nextSibling);
}
function Zn() {
  (Je = tt = null), (fe = !1);
}
function va(e) {
  gt === null ? (gt = [e]) : gt.push(e);
}
var Ym = It.ReactCurrentBatchConfig;
function mt(e, t) {
  if (e && e.defaultProps) {
    (t = he({}, t)), (e = e.defaultProps);
    for (var n in e) t[n] === void 0 && (t[n] = e[n]);
    return t;
  }
  return t;
}
var co = ln(null),
  fo = null,
  jn = null,
  ga = null;
function ya() {
  ga = jn = fo = null;
}
function Sa(e) {
  var t = co.current;
  ce(co), (e._currentValue = t);
}
function ws(e, t, n) {
  for (; e !== null; ) {
    var r = e.alternate;
    if (
      ((e.childLanes & t) !== t
        ? ((e.childLanes |= t), r !== null && (r.childLanes |= t))
        : r !== null && (r.childLanes & t) !== t && (r.childLanes |= t),
      e === n)
    )
      break;
    e = e.return;
  }
}
function Yn(e, t) {
  (fo = e),
    (ga = jn = null),
    (e = e.dependencies),
    e !== null &&
      e.firstContext !== null &&
      ((e.lanes & t) !== 0 && (Ge = !0), (e.firstContext = null));
}
function ft(e) {
  var t = e._currentValue;
  if (ga !== e)
    if (((e = { context: e, memoizedValue: t, next: null }), jn === null)) {
      if (fo === null) throw Error(R(308));
      (jn = e), (fo.dependencies = { lanes: 0, firstContext: e });
    } else jn = jn.next = e;
  return t;
}
var fn = null;
function wa(e) {
  fn === null ? (fn = [e]) : fn.push(e);
}
function id(e, t, n, r) {
  var i = t.interleaved;
  return (
    i === null ? ((n.next = n), wa(t)) : ((n.next = i.next), (i.next = n)),
    (t.interleaved = n),
    zt(e, r)
  );
}
function zt(e, t) {
  e.lanes |= t;
  var n = e.alternate;
  for (n !== null && (n.lanes |= t), n = e, e = e.return; e !== null; )
    (e.childLanes |= t),
      (n = e.alternate),
      n !== null && (n.childLanes |= t),
      (n = e),
      (e = e.return);
  return n.tag === 3 ? n.stateNode : null;
}
var Ft = !1;
function xa(e) {
  e.updateQueue = {
    baseState: e.memoizedState,
    firstBaseUpdate: null,
    lastBaseUpdate: null,
    shared: { pending: null, interleaved: null, lanes: 0 },
    effects: null,
  };
}
function od(e, t) {
  (e = e.updateQueue),
    t.updateQueue === e &&
      (t.updateQueue = {
        baseState: e.baseState,
        firstBaseUpdate: e.firstBaseUpdate,
        lastBaseUpdate: e.lastBaseUpdate,
        shared: e.shared,
        effects: e.effects,
      });
}
function Mt(e, t) {
  return {
    eventTime: e,
    lane: t,
    tag: 0,
    payload: null,
    callback: null,
    next: null,
  };
}
function Zt(e, t, n) {
  var r = e.updateQueue;
  if (r === null) return null;
  if (((r = r.shared), (ee & 2) !== 0)) {
    var i = r.pending;
    return (
      i === null ? (t.next = t) : ((t.next = i.next), (i.next = t)),
      (r.pending = t),
      zt(e, n)
    );
  }
  return (
    (i = r.interleaved),
    i === null ? ((t.next = t), wa(r)) : ((t.next = i.next), (i.next = t)),
    (r.interleaved = t),
    zt(e, n)
  );
}
function Vi(e, t, n) {
  if (
    ((t = t.updateQueue), t !== null && ((t = t.shared), (n & 4194240) !== 0))
  ) {
    var r = t.lanes;
    (r &= e.pendingLanes), (n |= r), (t.lanes = n), la(e, n);
  }
}
function Uu(e, t) {
  var n = e.updateQueue,
    r = e.alternate;
  if (r !== null && ((r = r.updateQueue), n === r)) {
    var i = null,
      o = null;
    if (((n = n.firstBaseUpdate), n !== null)) {
      do {
        var l = {
          eventTime: n.eventTime,
          lane: n.lane,
          tag: n.tag,
          payload: n.payload,
          callback: n.callback,
          next: null,
        };
        o === null ? (i = o = l) : (o = o.next = l), (n = n.next);
      } while (n !== null);
      o === null ? (i = o = t) : (o = o.next = t);
    } else i = o = t;
    (n = {
      baseState: r.baseState,
      firstBaseUpdate: i,
      lastBaseUpdate: o,
      shared: r.shared,
      effects: r.effects,
    }),
      (e.updateQueue = n);
    return;
  }
  (e = n.lastBaseUpdate),
    e === null ? (n.firstBaseUpdate = t) : (e.next = t),
    (n.lastBaseUpdate = t);
}
function po(e, t, n, r) {
  var i = e.updateQueue;
  Ft = !1;
  var o = i.firstBaseUpdate,
    l = i.lastBaseUpdate,
    a = i.shared.pending;
  if (a !== null) {
    i.shared.pending = null;
    var s = a,
      u = s.next;
    (s.next = null), l === null ? (o = u) : (l.next = u), (l = s);
    var c = e.alternate;
    c !== null &&
      ((c = c.updateQueue),
      (a = c.lastBaseUpdate),
      a !== l &&
        (a === null ? (c.firstBaseUpdate = u) : (a.next = u),
        (c.lastBaseUpdate = s)));
  }
  if (o !== null) {
    var f = i.baseState;
    (l = 0), (c = u = s = null), (a = o);
    do {
      var d = a.lane,
        v = a.eventTime;
      if ((r & d) === d) {
        c !== null &&
          (c = c.next =
            {
              eventTime: v,
              lane: 0,
              tag: a.tag,
              payload: a.payload,
              callback: a.callback,
              next: null,
            });
        e: {
          var g = e,
            y = a;
          switch (((d = t), (v = n), y.tag)) {
            case 1:
              if (((g = y.payload), typeof g == "function")) {
                f = g.call(v, f, d);
                break e;
              }
              f = g;
              break e;
            case 3:
              g.flags = (g.flags & -65537) | 128;
            case 0:
              if (
                ((g = y.payload),
                (d = typeof g == "function" ? g.call(v, f, d) : g),
                d == null)
              )
                break e;
              f = he({}, f, d);
              break e;
            case 2:
              Ft = !0;
          }
        }
        a.callback !== null &&
          a.lane !== 0 &&
          ((e.flags |= 64),
          (d = i.effects),
          d === null ? (i.effects = [a]) : d.push(a));
      } else
        (v = {
          eventTime: v,
          lane: d,
          tag: a.tag,
          payload: a.payload,
          callback: a.callback,
          next: null,
        }),
          c === null ? ((u = c = v), (s = f)) : (c = c.next = v),
          (l |= d);
      if (((a = a.next), a === null)) {
        if (((a = i.shared.pending), a === null)) break;
        (d = a),
          (a = d.next),
          (d.next = null),
          (i.lastBaseUpdate = d),
          (i.shared.pending = null);
      }
    } while (1);
    if (
      (c === null && (s = f),
      (i.baseState = s),
      (i.firstBaseUpdate = u),
      (i.lastBaseUpdate = c),
      (t = i.shared.interleaved),
      t !== null)
    ) {
      i = t;
      do (l |= i.lane), (i = i.next);
      while (i !== t);
    } else o === null && (i.shared.lanes = 0);
    (Sn |= l), (e.lanes = l), (e.memoizedState = f);
  }
}
function Wu(e, t, n) {
  if (((e = t.effects), (t.effects = null), e !== null))
    for (t = 0; t < e.length; t++) {
      var r = e[t],
        i = r.callback;
      if (i !== null) {
        if (((r.callback = null), (r = n), typeof i != "function"))
          throw Error(R(191, i));
        i.call(r);
      }
    }
}
var ld = new rf.Component().refs;
function xs(e, t, n, r) {
  (t = e.memoizedState),
    (n = n(r, t)),
    (n = n == null ? t : he({}, t, n)),
    (e.memoizedState = n),
    e.lanes === 0 && (e.updateQueue.baseState = n);
}
var zo = {
  isMounted: function (e) {
    return (e = e._reactInternals) ? $n(e) === e : !1;
  },
  enqueueSetState: function (e, t, n) {
    e = e._reactInternals;
    var r = Fe(),
      i = Jt(e),
      o = Mt(r, i);
    (o.payload = t),
      n != null && (o.callback = n),
      (t = Zt(e, o, i)),
      t !== null && (wt(t, e, i, r), Vi(t, e, i));
  },
  enqueueReplaceState: function (e, t, n) {
    e = e._reactInternals;
    var r = Fe(),
      i = Jt(e),
      o = Mt(r, i);
    (o.tag = 1),
      (o.payload = t),
      n != null && (o.callback = n),
      (t = Zt(e, o, i)),
      t !== null && (wt(t, e, i, r), Vi(t, e, i));
  },
  enqueueForceUpdate: function (e, t) {
    e = e._reactInternals;
    var n = Fe(),
      r = Jt(e),
      i = Mt(n, r);
    (i.tag = 2),
      t != null && (i.callback = t),
      (t = Zt(e, i, r)),
      t !== null && (wt(t, e, r, n), Vi(t, e, r));
  },
};
function Gu(e, t, n, r, i, o, l) {
  return (
    (e = e.stateNode),
    typeof e.shouldComponentUpdate == "function"
      ? e.shouldComponentUpdate(r, o, l)
      : t.prototype && t.prototype.isPureReactComponent
      ? !Qr(n, r) || !Qr(i, o)
      : !0
  );
}
function sd(e, t, n) {
  var r = !1,
    i = rn,
    o = t.contextType;
  return (
    typeof o == "object" && o !== null
      ? (o = ft(o))
      : ((i = Xe(t) ? vn : be.current),
        (r = t.contextTypes),
        (o = (r = r != null) ? Kn(e, i) : rn)),
    (t = new t(n, o)),
    (e.memoizedState = t.state !== null && t.state !== void 0 ? t.state : null),
    (t.updater = zo),
    (e.stateNode = t),
    (t._reactInternals = e),
    r &&
      ((e = e.stateNode),
      (e.__reactInternalMemoizedUnmaskedChildContext = i),
      (e.__reactInternalMemoizedMaskedChildContext = o)),
    t
  );
}
function Yu(e, t, n, r) {
  (e = t.state),
    typeof t.componentWillReceiveProps == "function" &&
      t.componentWillReceiveProps(n, r),
    typeof t.UNSAFE_componentWillReceiveProps == "function" &&
      t.UNSAFE_componentWillReceiveProps(n, r),
    t.state !== e && zo.enqueueReplaceState(t, t.state, null);
}
function Cs(e, t, n, r) {
  var i = e.stateNode;
  (i.props = n), (i.state = e.memoizedState), (i.refs = ld), xa(e);
  var o = t.contextType;
  typeof o == "object" && o !== null
    ? (i.context = ft(o))
    : ((o = Xe(t) ? vn : be.current), (i.context = Kn(e, o))),
    (i.state = e.memoizedState),
    (o = t.getDerivedStateFromProps),
    typeof o == "function" && (xs(e, t, o, n), (i.state = e.memoizedState)),
    typeof t.getDerivedStateFromProps == "function" ||
      typeof i.getSnapshotBeforeUpdate == "function" ||
      (typeof i.UNSAFE_componentWillMount != "function" &&
        typeof i.componentWillMount != "function") ||
      ((t = i.state),
      typeof i.componentWillMount == "function" && i.componentWillMount(),
      typeof i.UNSAFE_componentWillMount == "function" &&
        i.UNSAFE_componentWillMount(),
      t !== i.state && zo.enqueueReplaceState(i, i.state, null),
      po(e, n, i, r),
      (i.state = e.memoizedState)),
    typeof i.componentDidMount == "function" && (e.flags |= 4194308);
}
function Cr(e, t, n) {
  if (
    ((e = n.ref), e !== null && typeof e != "function" && typeof e != "object")
  ) {
    if (n._owner) {
      if (((n = n._owner), n)) {
        if (n.tag !== 1) throw Error(R(309));
        var r = n.stateNode;
      }
      if (!r) throw Error(R(147, e));
      var i = r,
        o = "" + e;
      return t !== null &&
        t.ref !== null &&
        typeof t.ref == "function" &&
        t.ref._stringRef === o
        ? t.ref
        : ((t = function (l) {
            var a = i.refs;
            a === ld && (a = i.refs = {}),
              l === null ? delete a[o] : (a[o] = l);
          }),
          (t._stringRef = o),
          t);
    }
    if (typeof e != "string") throw Error(R(284));
    if (!n._owner) throw Error(R(290, e));
  }
  return e;
}
function Pi(e, t) {
  throw (
    ((e = Object.prototype.toString.call(t)),
    Error(
      R(
        31,
        e === "[object Object]"
          ? "object with keys {" + Object.keys(t).join(", ") + "}"
          : e
      )
    ))
  );
}
function Xu(e) {
  var t = e._init;
  return t(e._payload);
}
function ad(e) {
  function t(h, p) {
    if (e) {
      var m = h.deletions;
      m === null ? ((h.deletions = [p]), (h.flags |= 16)) : m.push(p);
    }
  }
  function n(h, p) {
    if (!e) return null;
    for (; p !== null; ) t(h, p), (p = p.sibling);
    return null;
  }
  function r(h, p) {
    for (h = new Map(); p !== null; )
      p.key !== null ? h.set(p.key, p) : h.set(p.index, p), (p = p.sibling);
    return h;
  }
  function i(h, p) {
    return (h = en(h, p)), (h.index = 0), (h.sibling = null), h;
  }
  function o(h, p, m) {
    return (
      (h.index = m),
      e
        ? ((m = h.alternate),
          m !== null
            ? ((m = m.index), m < p ? ((h.flags |= 2), p) : m)
            : ((h.flags |= 2), p))
        : ((h.flags |= 1048576), p)
    );
  }
  function l(h) {
    return e && h.alternate === null && (h.flags |= 2), h;
  }
  function a(h, p, m, S) {
    return p === null || p.tag !== 6
      ? ((p = Ol(m, h.mode, S)), (p.return = h), p)
      : ((p = i(p, m)), (p.return = h), p);
  }
  function s(h, p, m, S) {
    var w = m.type;
    return w === Mn
      ? c(h, p, m.props.children, S, m.key)
      : p !== null &&
        (p.elementType === w ||
          (typeof w == "object" &&
            w !== null &&
            w.$$typeof === jt &&
            Xu(w) === p.type))
      ? ((S = i(p, m.props)), (S.ref = Cr(h, p, m)), (S.return = h), S)
      : ((S = Xi(m.type, m.key, m.props, null, h.mode, S)),
        (S.ref = Cr(h, p, m)),
        (S.return = h),
        S);
  }
  function u(h, p, m, S) {
    return p === null ||
      p.tag !== 4 ||
      p.stateNode.containerInfo !== m.containerInfo ||
      p.stateNode.implementation !== m.implementation
      ? ((p = Ml(m, h.mode, S)), (p.return = h), p)
      : ((p = i(p, m.children || [])), (p.return = h), p);
  }
  function c(h, p, m, S, w) {
    return p === null || p.tag !== 7
      ? ((p = hn(m, h.mode, S, w)), (p.return = h), p)
      : ((p = i(p, m)), (p.return = h), p);
  }
  function f(h, p, m) {
    if ((typeof p == "string" && p !== "") || typeof p == "number")
      return (p = Ol("" + p, h.mode, m)), (p.return = h), p;
    if (typeof p == "object" && p !== null) {
      switch (p.$$typeof) {
        case mi:
          return (
            (m = Xi(p.type, p.key, p.props, null, h.mode, m)),
            (m.ref = Cr(h, null, p)),
            (m.return = h),
            m
          );
        case On:
          return (p = Ml(p, h.mode, m)), (p.return = h), p;
        case jt:
          var S = p._init;
          return f(h, S(p._payload), m);
      }
      if ($r(p) || gr(p))
        return (p = hn(p, h.mode, m, null)), (p.return = h), p;
      Pi(h, p);
    }
    return null;
  }
  function d(h, p, m, S) {
    var w = p !== null ? p.key : null;
    if ((typeof m == "string" && m !== "") || typeof m == "number")
      return w !== null ? null : a(h, p, "" + m, S);
    if (typeof m == "object" && m !== null) {
      switch (m.$$typeof) {
        case mi:
          return m.key === w ? s(h, p, m, S) : null;
        case On:
          return m.key === w ? u(h, p, m, S) : null;
        case jt:
          return (w = m._init), d(h, p, w(m._payload), S);
      }
      if ($r(m) || gr(m)) return w !== null ? null : c(h, p, m, S, null);
      Pi(h, m);
    }
    return null;
  }
  function v(h, p, m, S, w) {
    if ((typeof S == "string" && S !== "") || typeof S == "number")
      return (h = h.get(m) || null), a(p, h, "" + S, w);
    if (typeof S == "object" && S !== null) {
      switch (S.$$typeof) {
        case mi:
          return (h = h.get(S.key === null ? m : S.key) || null), s(p, h, S, w);
        case On:
          return (h = h.get(S.key === null ? m : S.key) || null), u(p, h, S, w);
        case jt:
          var P = S._init;
          return v(h, p, m, P(S._payload), w);
      }
      if ($r(S) || gr(S)) return (h = h.get(m) || null), c(p, h, S, w, null);
      Pi(p, S);
    }
    return null;
  }
  function g(h, p, m, S) {
    for (
      var w = null, P = null, E = p, k = (p = 0), D = null;
      E !== null && k < m.length;
      k++
    ) {
      E.index > k ? ((D = E), (E = null)) : (D = E.sibling);
      var L = d(h, E, m[k], S);
      if (L === null) {
        E === null && (E = D);
        break;
      }
      e && E && L.alternate === null && t(h, E),
        (p = o(L, p, k)),
        P === null ? (w = L) : (P.sibling = L),
        (P = L),
        (E = D);
    }
    if (k === m.length) return n(h, E), fe && an(h, k), w;
    if (E === null) {
      for (; k < m.length; k++)
        (E = f(h, m[k], S)),
          E !== null &&
            ((p = o(E, p, k)), P === null ? (w = E) : (P.sibling = E), (P = E));
      return fe && an(h, k), w;
    }
    for (E = r(h, E); k < m.length; k++)
      (D = v(E, h, k, m[k], S)),
        D !== null &&
          (e && D.alternate !== null && E.delete(D.key === null ? k : D.key),
          (p = o(D, p, k)),
          P === null ? (w = D) : (P.sibling = D),
          (P = D));
    return (
      e &&
        E.forEach(function (T) {
          return t(h, T);
        }),
      fe && an(h, k),
      w
    );
  }
  function y(h, p, m, S) {
    var w = gr(m);
    if (typeof w != "function") throw Error(R(150));
    if (((m = w.call(m)), m == null)) throw Error(R(151));
    for (
      var P = (w = null), E = p, k = (p = 0), D = null, L = m.next();
      E !== null && !L.done;
      k++, L = m.next()
    ) {
      E.index > k ? ((D = E), (E = null)) : (D = E.sibling);
      var T = d(h, E, L.value, S);
      if (T === null) {
        E === null && (E = D);
        break;
      }
      e && E && T.alternate === null && t(h, E),
        (p = o(T, p, k)),
        P === null ? (w = T) : (P.sibling = T),
        (P = T),
        (E = D);
    }
    if (L.done) return n(h, E), fe && an(h, k), w;
    if (E === null) {
      for (; !L.done; k++, L = m.next())
        (L = f(h, L.value, S)),
          L !== null &&
            ((p = o(L, p, k)), P === null ? (w = L) : (P.sibling = L), (P = L));
      return fe && an(h, k), w;
    }
    for (E = r(h, E); !L.done; k++, L = m.next())
      (L = v(E, h, k, L.value, S)),
        L !== null &&
          (e && L.alternate !== null && E.delete(L.key === null ? k : L.key),
          (p = o(L, p, k)),
          P === null ? (w = L) : (P.sibling = L),
          (P = L));
    return (
      e &&
        E.forEach(function (N) {
          return t(h, N);
        }),
      fe && an(h, k),
      w
    );
  }
  function x(h, p, m, S) {
    if (
      (typeof m == "object" &&
        m !== null &&
        m.type === Mn &&
        m.key === null &&
        (m = m.props.children),
      typeof m == "object" && m !== null)
    ) {
      switch (m.$$typeof) {
        case mi:
          e: {
            for (var w = m.key, P = p; P !== null; ) {
              if (P.key === w) {
                if (((w = m.type), w === Mn)) {
                  if (P.tag === 7) {
                    n(h, P.sibling),
                      (p = i(P, m.props.children)),
                      (p.return = h),
                      (h = p);
                    break e;
                  }
                } else if (
                  P.elementType === w ||
                  (typeof w == "object" &&
                    w !== null &&
                    w.$$typeof === jt &&
                    Xu(w) === P.type)
                ) {
                  n(h, P.sibling),
                    (p = i(P, m.props)),
                    (p.ref = Cr(h, P, m)),
                    (p.return = h),
                    (h = p);
                  break e;
                }
                n(h, P);
                break;
              } else t(h, P);
              P = P.sibling;
            }
            m.type === Mn
              ? ((p = hn(m.props.children, h.mode, S, m.key)),
                (p.return = h),
                (h = p))
              : ((S = Xi(m.type, m.key, m.props, null, h.mode, S)),
                (S.ref = Cr(h, p, m)),
                (S.return = h),
                (h = S));
          }
          return l(h);
        case On:
          e: {
            for (P = m.key; p !== null; ) {
              if (p.key === P)
                if (
                  p.tag === 4 &&
                  p.stateNode.containerInfo === m.containerInfo &&
                  p.stateNode.implementation === m.implementation
                ) {
                  n(h, p.sibling),
                    (p = i(p, m.children || [])),
                    (p.return = h),
                    (h = p);
                  break e;
                } else {
                  n(h, p);
                  break;
                }
              else t(h, p);
              p = p.sibling;
            }
            (p = Ml(m, h.mode, S)), (p.return = h), (h = p);
          }
          return l(h);
        case jt:
          return (P = m._init), x(h, p, P(m._payload), S);
      }
      if ($r(m)) return g(h, p, m, S);
      if (gr(m)) return y(h, p, m, S);
      Pi(h, m);
    }
    return (typeof m == "string" && m !== "") || typeof m == "number"
      ? ((m = "" + m),
        p !== null && p.tag === 6
          ? (n(h, p.sibling), (p = i(p, m)), (p.return = h), (h = p))
          : (n(h, p), (p = Ol(m, h.mode, S)), (p.return = h), (h = p)),
        l(h))
      : n(h, p);
  }
  return x;
}
var qn = ad(!0),
  ud = ad(!1),
  fi = {},
  Pt = ln(fi),
  Jr = ln(fi),
  ei = ln(fi);
function dn(e) {
  if (e === fi) throw Error(R(174));
  return e;
}
function Ca(e, t) {
  switch ((se(ei, t), se(Jr, e), se(Pt, fi), (e = t.nodeType), e)) {
    case 9:
    case 11:
      t = (t = t.documentElement) ? t.namespaceURI : es(null, "");
      break;
    default:
      (e = e === 8 ? t.parentNode : t),
        (t = e.namespaceURI || null),
        (e = e.tagName),
        (t = es(t, e));
  }
  ce(Pt), se(Pt, t);
}
function Jn() {
  ce(Pt), ce(Jr), ce(ei);
}
function cd(e) {
  dn(ei.current);
  var t = dn(Pt.current),
    n = es(t, e.type);
  t !== n && (se(Jr, e), se(Pt, n));
}
function Ea(e) {
  Jr.current === e && (ce(Pt), ce(Jr));
}
var de = ln(0);
function ho(e) {
  for (var t = e; t !== null; ) {
    if (t.tag === 13) {
      var n = t.memoizedState;
      if (
        n !== null &&
        ((n = n.dehydrated), n === null || n.data === "$?" || n.data === "$!")
      )
        return t;
    } else if (t.tag === 19 && t.memoizedProps.revealOrder !== void 0) {
      if ((t.flags & 128) !== 0) return t;
    } else if (t.child !== null) {
      (t.child.return = t), (t = t.child);
      continue;
    }
    if (t === e) break;
    for (; t.sibling === null; ) {
      if (t.return === null || t.return === e) return null;
      t = t.return;
    }
    (t.sibling.return = t.return), (t = t.sibling);
  }
  return null;
}
var Tl = [];
function Ta() {
  for (var e = 0; e < Tl.length; e++)
    Tl[e]._workInProgressVersionPrimary = null;
  Tl.length = 0;
}
var Hi = It.ReactCurrentDispatcher,
  kl = It.ReactCurrentBatchConfig,
  yn = 0,
  pe = null,
  we = null,
  Ee = null,
  mo = !1,
  Rr = !1,
  ti = 0,
  Xm = 0;
function ze() {
  throw Error(R(321));
}
function ka(e, t) {
  if (t === null) return !1;
  for (var n = 0; n < t.length && n < e.length; n++)
    if (!xt(e[n], t[n])) return !1;
  return !0;
}
function Pa(e, t, n, r, i, o) {
  if (
    ((yn = o),
    (pe = t),
    (t.memoizedState = null),
    (t.updateQueue = null),
    (t.lanes = 0),
    (Hi.current = e === null || e.memoizedState === null ? qm : Jm),
    (e = n(r, i)),
    Rr)
  ) {
    o = 0;
    do {
      if (((Rr = !1), (ti = 0), 25 <= o)) throw Error(R(301));
      (o += 1),
        (Ee = we = null),
        (t.updateQueue = null),
        (Hi.current = ev),
        (e = n(r, i));
    } while (Rr);
  }
  if (
    ((Hi.current = vo),
    (t = we !== null && we.next !== null),
    (yn = 0),
    (Ee = we = pe = null),
    (mo = !1),
    t)
  )
    throw Error(R(300));
  return e;
}
function $a() {
  var e = ti !== 0;
  return (ti = 0), e;
}
function Et() {
  var e = {
    memoizedState: null,
    baseState: null,
    baseQueue: null,
    queue: null,
    next: null,
  };
  return Ee === null ? (pe.memoizedState = Ee = e) : (Ee = Ee.next = e), Ee;
}
function dt() {
  if (we === null) {
    var e = pe.alternate;
    e = e !== null ? e.memoizedState : null;
  } else e = we.next;
  var t = Ee === null ? pe.memoizedState : Ee.next;
  if (t !== null) (Ee = t), (we = e);
  else {
    if (e === null) throw Error(R(310));
    (we = e),
      (e = {
        memoizedState: we.memoizedState,
        baseState: we.baseState,
        baseQueue: we.baseQueue,
        queue: we.queue,
        next: null,
      }),
      Ee === null ? (pe.memoizedState = Ee = e) : (Ee = Ee.next = e);
  }
  return Ee;
}
function ni(e, t) {
  return typeof t == "function" ? t(e) : t;
}
function Pl(e) {
  var t = dt(),
    n = t.queue;
  if (n === null) throw Error(R(311));
  n.lastRenderedReducer = e;
  var r = we,
    i = r.baseQueue,
    o = n.pending;
  if (o !== null) {
    if (i !== null) {
      var l = i.next;
      (i.next = o.next), (o.next = l);
    }
    (r.baseQueue = i = o), (n.pending = null);
  }
  if (i !== null) {
    (o = i.next), (r = r.baseState);
    var a = (l = null),
      s = null,
      u = o;
    do {
      var c = u.lane;
      if ((yn & c) === c)
        s !== null &&
          (s = s.next =
            {
              lane: 0,
              action: u.action,
              hasEagerState: u.hasEagerState,
              eagerState: u.eagerState,
              next: null,
            }),
          (r = u.hasEagerState ? u.eagerState : e(r, u.action));
      else {
        var f = {
          lane: c,
          action: u.action,
          hasEagerState: u.hasEagerState,
          eagerState: u.eagerState,
          next: null,
        };
        s === null ? ((a = s = f), (l = r)) : (s = s.next = f),
          (pe.lanes |= c),
          (Sn |= c);
      }
      u = u.next;
    } while (u !== null && u !== o);
    s === null ? (l = r) : (s.next = a),
      xt(r, t.memoizedState) || (Ge = !0),
      (t.memoizedState = r),
      (t.baseState = l),
      (t.baseQueue = s),
      (n.lastRenderedState = r);
  }
  if (((e = n.interleaved), e !== null)) {
    i = e;
    do (o = i.lane), (pe.lanes |= o), (Sn |= o), (i = i.next);
    while (i !== e);
  } else i === null && (n.lanes = 0);
  return [t.memoizedState, n.dispatch];
}
function $l(e) {
  var t = dt(),
    n = t.queue;
  if (n === null) throw Error(R(311));
  n.lastRenderedReducer = e;
  var r = n.dispatch,
    i = n.pending,
    o = t.memoizedState;
  if (i !== null) {
    n.pending = null;
    var l = (i = i.next);
    do (o = e(o, l.action)), (l = l.next);
    while (l !== i);
    xt(o, t.memoizedState) || (Ge = !0),
      (t.memoizedState = o),
      t.baseQueue === null && (t.baseState = o),
      (n.lastRenderedState = o);
  }
  return [o, r];
}
function fd() {}
function dd(e, t) {
  var n = pe,
    r = dt(),
    i = t(),
    o = !xt(r.memoizedState, i);
  if (
    (o && ((r.memoizedState = i), (Ge = !0)),
    (r = r.queue),
    _a(md.bind(null, n, r, e), [e]),
    r.getSnapshot !== t || o || (Ee !== null && Ee.memoizedState.tag & 1))
  ) {
    if (
      ((n.flags |= 2048),
      ri(9, hd.bind(null, n, r, i, t), void 0, null),
      ke === null)
    )
      throw Error(R(349));
    (yn & 30) !== 0 || pd(n, t, i);
  }
  return i;
}
function pd(e, t, n) {
  (e.flags |= 16384),
    (e = { getSnapshot: t, value: n }),
    (t = pe.updateQueue),
    t === null
      ? ((t = { lastEffect: null, stores: null }),
        (pe.updateQueue = t),
        (t.stores = [e]))
      : ((n = t.stores), n === null ? (t.stores = [e]) : n.push(e));
}
function hd(e, t, n, r) {
  (t.value = n), (t.getSnapshot = r), vd(t) && gd(e);
}
function md(e, t, n) {
  return n(function () {
    vd(t) && gd(e);
  });
}
function vd(e) {
  var t = e.getSnapshot;
  e = e.value;
  try {
    var n = t();
    return !xt(e, n);
  } catch {
    return !0;
  }
}
function gd(e) {
  var t = zt(e, 1);
  t !== null && wt(t, e, 1, -1);
}
function Qu(e) {
  var t = Et();
  return (
    typeof e == "function" && (e = e()),
    (t.memoizedState = t.baseState = e),
    (e = {
      pending: null,
      interleaved: null,
      lanes: 0,
      dispatch: null,
      lastRenderedReducer: ni,
      lastRenderedState: e,
    }),
    (t.queue = e),
    (e = e.dispatch = Zm.bind(null, pe, e)),
    [t.memoizedState, e]
  );
}
function ri(e, t, n, r) {
  return (
    (e = { tag: e, create: t, destroy: n, deps: r, next: null }),
    (t = pe.updateQueue),
    t === null
      ? ((t = { lastEffect: null, stores: null }),
        (pe.updateQueue = t),
        (t.lastEffect = e.next = e))
      : ((n = t.lastEffect),
        n === null
          ? (t.lastEffect = e.next = e)
          : ((r = n.next), (n.next = e), (e.next = r), (t.lastEffect = e))),
    e
  );
}
function yd() {
  return dt().memoizedState;
}
function Ui(e, t, n, r) {
  var i = Et();
  (pe.flags |= e),
    (i.memoizedState = ri(1 | t, n, void 0, r === void 0 ? null : r));
}
function Ro(e, t, n, r) {
  var i = dt();
  r = r === void 0 ? null : r;
  var o = void 0;
  if (we !== null) {
    var l = we.memoizedState;
    if (((o = l.destroy), r !== null && ka(r, l.deps))) {
      i.memoizedState = ri(t, n, o, r);
      return;
    }
  }
  (pe.flags |= e), (i.memoizedState = ri(1 | t, n, o, r));
}
function Ku(e, t) {
  return Ui(8390656, 8, e, t);
}
function _a(e, t) {
  return Ro(2048, 8, e, t);
}
function Sd(e, t) {
  return Ro(4, 2, e, t);
}
function wd(e, t) {
  return Ro(4, 4, e, t);
}
function xd(e, t) {
  if (typeof t == "function")
    return (
      (e = e()),
      t(e),
      function () {
        t(null);
      }
    );
  if (t != null)
    return (
      (e = e()),
      (t.current = e),
      function () {
        t.current = null;
      }
    );
}
function Cd(e, t, n) {
  return (
    (n = n != null ? n.concat([e]) : null), Ro(4, 4, xd.bind(null, t, e), n)
  );
}
function La() {}
function Ed(e, t) {
  var n = dt();
  t = t === void 0 ? null : t;
  var r = n.memoizedState;
  return r !== null && t !== null && ka(t, r[1])
    ? r[0]
    : ((n.memoizedState = [e, t]), e);
}
function Td(e, t) {
  var n = dt();
  t = t === void 0 ? null : t;
  var r = n.memoizedState;
  return r !== null && t !== null && ka(t, r[1])
    ? r[0]
    : ((e = e()), (n.memoizedState = [e, t]), e);
}
function kd(e, t, n) {
  return (yn & 21) === 0
    ? (e.baseState && ((e.baseState = !1), (Ge = !0)), (e.memoizedState = n))
    : (xt(n, t) || ((n = _f()), (pe.lanes |= n), (Sn |= n), (e.baseState = !0)),
      t);
}
function Qm(e, t) {
  var n = oe;
  (oe = n !== 0 && 4 > n ? n : 4), e(!0);
  var r = kl.transition;
  kl.transition = {};
  try {
    e(!1), t();
  } finally {
    (oe = n), (kl.transition = r);
  }
}
function Pd() {
  return dt().memoizedState;
}
function Km(e, t, n) {
  var r = Jt(e);
  if (
    ((n = {
      lane: r,
      action: n,
      hasEagerState: !1,
      eagerState: null,
      next: null,
    }),
    $d(e))
  )
    _d(t, n);
  else if (((n = id(e, t, n, r)), n !== null)) {
    var i = Fe();
    wt(n, e, r, i), Ld(n, t, r);
  }
}
function Zm(e, t, n) {
  var r = Jt(e),
    i = { lane: r, action: n, hasEagerState: !1, eagerState: null, next: null };
  if ($d(e)) _d(t, i);
  else {
    var o = e.alternate;
    if (
      e.lanes === 0 &&
      (o === null || o.lanes === 0) &&
      ((o = t.lastRenderedReducer), o !== null)
    )
      try {
        var l = t.lastRenderedState,
          a = o(l, n);
        if (((i.hasEagerState = !0), (i.eagerState = a), xt(a, l))) {
          var s = t.interleaved;
          s === null
            ? ((i.next = i), wa(t))
            : ((i.next = s.next), (s.next = i)),
            (t.interleaved = i);
          return;
        }
      } catch {
      } finally {
      }
    (n = id(e, t, i, r)),
      n !== null && ((i = Fe()), wt(n, e, r, i), Ld(n, t, r));
  }
}
function $d(e) {
  var t = e.alternate;
  return e === pe || (t !== null && t === pe);
}
function _d(e, t) {
  Rr = mo = !0;
  var n = e.pending;
  n === null ? (t.next = t) : ((t.next = n.next), (n.next = t)),
    (e.pending = t);
}
function Ld(e, t, n) {
  if ((n & 4194240) !== 0) {
    var r = t.lanes;
    (r &= e.pendingLanes), (n |= r), (t.lanes = n), la(e, n);
  }
}
var vo = {
    readContext: ft,
    useCallback: ze,
    useContext: ze,
    useEffect: ze,
    useImperativeHandle: ze,
    useInsertionEffect: ze,
    useLayoutEffect: ze,
    useMemo: ze,
    useReducer: ze,
    useRef: ze,
    useState: ze,
    useDebugValue: ze,
    useDeferredValue: ze,
    useTransition: ze,
    useMutableSource: ze,
    useSyncExternalStore: ze,
    useId: ze,
    unstable_isNewReconciler: !1,
  },
  qm = {
    readContext: ft,
    useCallback: function (e, t) {
      return (Et().memoizedState = [e, t === void 0 ? null : t]), e;
    },
    useContext: ft,
    useEffect: Ku,
    useImperativeHandle: function (e, t, n) {
      return (
        (n = n != null ? n.concat([e]) : null),
        Ui(4194308, 4, xd.bind(null, t, e), n)
      );
    },
    useLayoutEffect: function (e, t) {
      return Ui(4194308, 4, e, t);
    },
    useInsertionEffect: function (e, t) {
      return Ui(4, 2, e, t);
    },
    useMemo: function (e, t) {
      var n = Et();
      return (
        (t = t === void 0 ? null : t), (e = e()), (n.memoizedState = [e, t]), e
      );
    },
    useReducer: function (e, t, n) {
      var r = Et();
      return (
        (t = n !== void 0 ? n(t) : t),
        (r.memoizedState = r.baseState = t),
        (e = {
          pending: null,
          interleaved: null,
          lanes: 0,
          dispatch: null,
          lastRenderedReducer: e,
          lastRenderedState: t,
        }),
        (r.queue = e),
        (e = e.dispatch = Km.bind(null, pe, e)),
        [r.memoizedState, e]
      );
    },
    useRef: function (e) {
      var t = Et();
      return (e = { current: e }), (t.memoizedState = e);
    },
    useState: Qu,
    useDebugValue: La,
    useDeferredValue: function (e) {
      return (Et().memoizedState = e);
    },
    useTransition: function () {
      var e = Qu(!1),
        t = e[0];
      return (e = Qm.bind(null, e[1])), (Et().memoizedState = e), [t, e];
    },
    useMutableSource: function () {},
    useSyncExternalStore: function (e, t, n) {
      var r = pe,
        i = Et();
      if (fe) {
        if (n === void 0) throw Error(R(407));
        n = n();
      } else {
        if (((n = t()), ke === null)) throw Error(R(349));
        (yn & 30) !== 0 || pd(r, t, n);
      }
      i.memoizedState = n;
      var o = { value: n, getSnapshot: t };
      return (
        (i.queue = o),
        Ku(md.bind(null, r, o, e), [e]),
        (r.flags |= 2048),
        ri(9, hd.bind(null, r, o, n, t), void 0, null),
        n
      );
    },
    useId: function () {
      var e = Et(),
        t = ke.identifierPrefix;
      if (fe) {
        var n = Ot,
          r = Lt;
        (n = (r & ~(1 << (32 - St(r) - 1))).toString(32) + n),
          (t = ":" + t + "R" + n),
          (n = ti++),
          0 < n && (t += "H" + n.toString(32)),
          (t += ":");
      } else (n = Xm++), (t = ":" + t + "r" + n.toString(32) + ":");
      return (e.memoizedState = t);
    },
    unstable_isNewReconciler: !1,
  },
  Jm = {
    readContext: ft,
    useCallback: Ed,
    useContext: ft,
    useEffect: _a,
    useImperativeHandle: Cd,
    useInsertionEffect: Sd,
    useLayoutEffect: wd,
    useMemo: Td,
    useReducer: Pl,
    useRef: yd,
    useState: function () {
      return Pl(ni);
    },
    useDebugValue: La,
    useDeferredValue: function (e) {
      var t = dt();
      return kd(t, we.memoizedState, e);
    },
    useTransition: function () {
      var e = Pl(ni)[0],
        t = dt().memoizedState;
      return [e, t];
    },
    useMutableSource: fd,
    useSyncExternalStore: dd,
    useId: Pd,
    unstable_isNewReconciler: !1,
  },
  ev = {
    readContext: ft,
    useCallback: Ed,
    useContext: ft,
    useEffect: _a,
    useImperativeHandle: Cd,
    useInsertionEffect: Sd,
    useLayoutEffect: wd,
    useMemo: Td,
    useReducer: $l,
    useRef: yd,
    useState: function () {
      return $l(ni);
    },
    useDebugValue: La,
    useDeferredValue: function (e) {
      var t = dt();
      return we === null ? (t.memoizedState = e) : kd(t, we.memoizedState, e);
    },
    useTransition: function () {
      var e = $l(ni)[0],
        t = dt().memoizedState;
      return [e, t];
    },
    useMutableSource: fd,
    useSyncExternalStore: dd,
    useId: Pd,
    unstable_isNewReconciler: !1,
  };
function er(e, t) {
  try {
    var n = "",
      r = t;
    do (n += _h(r)), (r = r.return);
    while (r);
    var i = n;
  } catch (o) {
    i =
      `
Error generating stack: ` +
      o.message +
      `
` +
      o.stack;
  }
  return { value: e, source: t, stack: i, digest: null };
}
function _l(e, t, n) {
  return {
    value: e,
    source: null,
    stack: n != null ? n : null,
    digest: t != null ? t : null,
  };
}
function Es(e, t) {
  try {
    console.error(t.value);
  } catch (n) {
    setTimeout(function () {
      throw n;
    });
  }
}
var tv = typeof WeakMap == "function" ? WeakMap : Map;
function Od(e, t, n) {
  (n = Mt(-1, n)), (n.tag = 3), (n.payload = { element: null });
  var r = t.value;
  return (
    (n.callback = function () {
      yo || ((yo = !0), (As = r)), Es(e, t);
    }),
    n
  );
}
function Md(e, t, n) {
  (n = Mt(-1, n)), (n.tag = 3);
  var r = e.type.getDerivedStateFromError;
  if (typeof r == "function") {
    var i = t.value;
    (n.payload = function () {
      return r(i);
    }),
      (n.callback = function () {
        Es(e, t);
      });
  }
  var o = e.stateNode;
  return (
    o !== null &&
      typeof o.componentDidCatch == "function" &&
      (n.callback = function () {
        Es(e, t),
          typeof r != "function" &&
            (qt === null ? (qt = new Set([this])) : qt.add(this));
        var l = t.stack;
        this.componentDidCatch(t.value, {
          componentStack: l !== null ? l : "",
        });
      }),
    n
  );
}
function Zu(e, t, n) {
  var r = e.pingCache;
  if (r === null) {
    r = e.pingCache = new tv();
    var i = new Set();
    r.set(t, i);
  } else (i = r.get(t)), i === void 0 && ((i = new Set()), r.set(t, i));
  i.has(n) || (i.add(n), (e = mv.bind(null, e, t, n)), t.then(e, e));
}
function qu(e) {
  do {
    var t;
    if (
      ((t = e.tag === 13) &&
        ((t = e.memoizedState), (t = t !== null ? t.dehydrated !== null : !0)),
      t)
    )
      return e;
    e = e.return;
  } while (e !== null);
  return null;
}
function Ju(e, t, n, r, i) {
  return (e.mode & 1) === 0
    ? (e === t
        ? (e.flags |= 65536)
        : ((e.flags |= 128),
          (n.flags |= 131072),
          (n.flags &= -52805),
          n.tag === 1 &&
            (n.alternate === null
              ? (n.tag = 17)
              : ((t = Mt(-1, 1)), (t.tag = 2), Zt(n, t, 1))),
          (n.lanes |= 1)),
      e)
    : ((e.flags |= 65536), (e.lanes = i), e);
}
var nv = It.ReactCurrentOwner,
  Ge = !1;
function De(e, t, n, r) {
  t.child = e === null ? ud(t, null, n, r) : qn(t, e.child, n, r);
}
function ec(e, t, n, r, i) {
  n = n.render;
  var o = t.ref;
  return (
    Yn(t, i),
    (r = Pa(e, t, n, r, o, i)),
    (n = $a()),
    e !== null && !Ge
      ? ((t.updateQueue = e.updateQueue),
        (t.flags &= -2053),
        (e.lanes &= ~i),
        Rt(e, t, i))
      : (fe && n && ha(t), (t.flags |= 1), De(e, t, r, i), t.child)
  );
}
function tc(e, t, n, r, i) {
  if (e === null) {
    var o = n.type;
    return typeof o == "function" &&
      !ba(o) &&
      o.defaultProps === void 0 &&
      n.compare === null &&
      n.defaultProps === void 0
      ? ((t.tag = 15), (t.type = o), Nd(e, t, o, r, i))
      : ((e = Xi(n.type, null, r, t, t.mode, i)),
        (e.ref = t.ref),
        (e.return = t),
        (t.child = e));
  }
  if (((o = e.child), (e.lanes & i) === 0)) {
    var l = o.memoizedProps;
    if (
      ((n = n.compare), (n = n !== null ? n : Qr), n(l, r) && e.ref === t.ref)
    )
      return Rt(e, t, i);
  }
  return (
    (t.flags |= 1),
    (e = en(o, r)),
    (e.ref = t.ref),
    (e.return = t),
    (t.child = e)
  );
}
function Nd(e, t, n, r, i) {
  if (e !== null) {
    var o = e.memoizedProps;
    if (Qr(o, r) && e.ref === t.ref)
      if (((Ge = !1), (t.pendingProps = r = o), (e.lanes & i) !== 0))
        (e.flags & 131072) !== 0 && (Ge = !0);
      else return (t.lanes = e.lanes), Rt(e, t, i);
  }
  return Ts(e, t, n, r, i);
}
function Ad(e, t, n) {
  var r = t.pendingProps,
    i = r.children,
    o = e !== null ? e.memoizedState : null;
  if (r.mode === "hidden")
    if ((t.mode & 1) === 0)
      (t.memoizedState = { baseLanes: 0, cachePool: null, transitions: null }),
        se(Bn, Ke),
        (Ke |= n);
    else {
      if ((n & 1073741824) === 0)
        return (
          (e = o !== null ? o.baseLanes | n : n),
          (t.lanes = t.childLanes = 1073741824),
          (t.memoizedState = {
            baseLanes: e,
            cachePool: null,
            transitions: null,
          }),
          (t.updateQueue = null),
          se(Bn, Ke),
          (Ke |= e),
          null
        );
      (t.memoizedState = { baseLanes: 0, cachePool: null, transitions: null }),
        (r = o !== null ? o.baseLanes : n),
        se(Bn, Ke),
        (Ke |= r);
    }
  else
    o !== null ? ((r = o.baseLanes | n), (t.memoizedState = null)) : (r = n),
      se(Bn, Ke),
      (Ke |= r);
  return De(e, t, i, n), t.child;
}
function zd(e, t) {
  var n = t.ref;
  ((e === null && n !== null) || (e !== null && e.ref !== n)) &&
    ((t.flags |= 512), (t.flags |= 2097152));
}
function Ts(e, t, n, r, i) {
  var o = Xe(n) ? vn : be.current;
  return (
    (o = Kn(t, o)),
    Yn(t, i),
    (n = Pa(e, t, n, r, o, i)),
    (r = $a()),
    e !== null && !Ge
      ? ((t.updateQueue = e.updateQueue),
        (t.flags &= -2053),
        (e.lanes &= ~i),
        Rt(e, t, i))
      : (fe && r && ha(t), (t.flags |= 1), De(e, t, n, i), t.child)
  );
}
function nc(e, t, n, r, i) {
  if (Xe(n)) {
    var o = !0;
    so(t);
  } else o = !1;
  if ((Yn(t, i), t.stateNode === null))
    Wi(e, t), sd(t, n, r), Cs(t, n, r, i), (r = !0);
  else if (e === null) {
    var l = t.stateNode,
      a = t.memoizedProps;
    l.props = a;
    var s = l.context,
      u = n.contextType;
    typeof u == "object" && u !== null
      ? (u = ft(u))
      : ((u = Xe(n) ? vn : be.current), (u = Kn(t, u)));
    var c = n.getDerivedStateFromProps,
      f =
        typeof c == "function" ||
        typeof l.getSnapshotBeforeUpdate == "function";
    f ||
      (typeof l.UNSAFE_componentWillReceiveProps != "function" &&
        typeof l.componentWillReceiveProps != "function") ||
      ((a !== r || s !== u) && Yu(t, l, r, u)),
      (Ft = !1);
    var d = t.memoizedState;
    (l.state = d),
      po(t, r, l, i),
      (s = t.memoizedState),
      a !== r || d !== s || Ye.current || Ft
        ? (typeof c == "function" && (xs(t, n, c, r), (s = t.memoizedState)),
          (a = Ft || Gu(t, n, a, r, d, s, u))
            ? (f ||
                (typeof l.UNSAFE_componentWillMount != "function" &&
                  typeof l.componentWillMount != "function") ||
                (typeof l.componentWillMount == "function" &&
                  l.componentWillMount(),
                typeof l.UNSAFE_componentWillMount == "function" &&
                  l.UNSAFE_componentWillMount()),
              typeof l.componentDidMount == "function" && (t.flags |= 4194308))
            : (typeof l.componentDidMount == "function" && (t.flags |= 4194308),
              (t.memoizedProps = r),
              (t.memoizedState = s)),
          (l.props = r),
          (l.state = s),
          (l.context = u),
          (r = a))
        : (typeof l.componentDidMount == "function" && (t.flags |= 4194308),
          (r = !1));
  } else {
    (l = t.stateNode),
      od(e, t),
      (a = t.memoizedProps),
      (u = t.type === t.elementType ? a : mt(t.type, a)),
      (l.props = u),
      (f = t.pendingProps),
      (d = l.context),
      (s = n.contextType),
      typeof s == "object" && s !== null
        ? (s = ft(s))
        : ((s = Xe(n) ? vn : be.current), (s = Kn(t, s)));
    var v = n.getDerivedStateFromProps;
    (c =
      typeof v == "function" ||
      typeof l.getSnapshotBeforeUpdate == "function") ||
      (typeof l.UNSAFE_componentWillReceiveProps != "function" &&
        typeof l.componentWillReceiveProps != "function") ||
      ((a !== f || d !== s) && Yu(t, l, r, s)),
      (Ft = !1),
      (d = t.memoizedState),
      (l.state = d),
      po(t, r, l, i);
    var g = t.memoizedState;
    a !== f || d !== g || Ye.current || Ft
      ? (typeof v == "function" && (xs(t, n, v, r), (g = t.memoizedState)),
        (u = Ft || Gu(t, n, u, r, d, g, s) || !1)
          ? (c ||
              (typeof l.UNSAFE_componentWillUpdate != "function" &&
                typeof l.componentWillUpdate != "function") ||
              (typeof l.componentWillUpdate == "function" &&
                l.componentWillUpdate(r, g, s),
              typeof l.UNSAFE_componentWillUpdate == "function" &&
                l.UNSAFE_componentWillUpdate(r, g, s)),
            typeof l.componentDidUpdate == "function" && (t.flags |= 4),
            typeof l.getSnapshotBeforeUpdate == "function" && (t.flags |= 1024))
          : (typeof l.componentDidUpdate != "function" ||
              (a === e.memoizedProps && d === e.memoizedState) ||
              (t.flags |= 4),
            typeof l.getSnapshotBeforeUpdate != "function" ||
              (a === e.memoizedProps && d === e.memoizedState) ||
              (t.flags |= 1024),
            (t.memoizedProps = r),
            (t.memoizedState = g)),
        (l.props = r),
        (l.state = g),
        (l.context = s),
        (r = u))
      : (typeof l.componentDidUpdate != "function" ||
          (a === e.memoizedProps && d === e.memoizedState) ||
          (t.flags |= 4),
        typeof l.getSnapshotBeforeUpdate != "function" ||
          (a === e.memoizedProps && d === e.memoizedState) ||
          (t.flags |= 1024),
        (r = !1));
  }
  return ks(e, t, n, r, o, i);
}
function ks(e, t, n, r, i, o) {
  zd(e, t);
  var l = (t.flags & 128) !== 0;
  if (!r && !l) return i && Bu(t, n, !1), Rt(e, t, o);
  (r = t.stateNode), (nv.current = t);
  var a =
    l && typeof n.getDerivedStateFromError != "function" ? null : r.render();
  return (
    (t.flags |= 1),
    e !== null && l
      ? ((t.child = qn(t, e.child, null, o)), (t.child = qn(t, null, a, o)))
      : De(e, t, a, o),
    (t.memoizedState = r.state),
    i && Bu(t, n, !0),
    t.child
  );
}
function Rd(e) {
  var t = e.stateNode;
  t.pendingContext
    ? Fu(e, t.pendingContext, t.pendingContext !== t.context)
    : t.context && Fu(e, t.context, !1),
    Ca(e, t.containerInfo);
}
function rc(e, t, n, r, i) {
  return Zn(), va(i), (t.flags |= 256), De(e, t, n, r), t.child;
}
var Ps = { dehydrated: null, treeContext: null, retryLane: 0 };
function $s(e) {
  return { baseLanes: e, cachePool: null, transitions: null };
}
function Id(e, t, n) {
  var r = t.pendingProps,
    i = de.current,
    o = !1,
    l = (t.flags & 128) !== 0,
    a;
  if (
    ((a = l) ||
      (a = e !== null && e.memoizedState === null ? !1 : (i & 2) !== 0),
    a
      ? ((o = !0), (t.flags &= -129))
      : (e === null || e.memoizedState !== null) && (i |= 1),
    se(de, i & 1),
    e === null)
  )
    return (
      Ss(t),
      (e = t.memoizedState),
      e !== null && ((e = e.dehydrated), e !== null)
        ? ((t.mode & 1) === 0
            ? (t.lanes = 1)
            : e.data === "$!"
            ? (t.lanes = 8)
            : (t.lanes = 1073741824),
          null)
        : ((l = r.children),
          (e = r.fallback),
          o
            ? ((r = t.mode),
              (o = t.child),
              (l = { mode: "hidden", children: l }),
              (r & 1) === 0 && o !== null
                ? ((o.childLanes = 0), (o.pendingProps = l))
                : (o = Do(l, r, 0, null)),
              (e = hn(e, r, n, null)),
              (o.return = t),
              (e.return = t),
              (o.sibling = e),
              (t.child = o),
              (t.child.memoizedState = $s(n)),
              (t.memoizedState = Ps),
              e)
            : Oa(t, l))
    );
  if (((i = e.memoizedState), i !== null && ((a = i.dehydrated), a !== null)))
    return rv(e, t, l, r, a, i, n);
  if (o) {
    (o = r.fallback), (l = t.mode), (i = e.child), (a = i.sibling);
    var s = { mode: "hidden", children: r.children };
    return (
      (l & 1) === 0 && t.child !== i
        ? ((r = t.child),
          (r.childLanes = 0),
          (r.pendingProps = s),
          (t.deletions = null))
        : ((r = en(i, s)), (r.subtreeFlags = i.subtreeFlags & 14680064)),
      a !== null ? (o = en(a, o)) : ((o = hn(o, l, n, null)), (o.flags |= 2)),
      (o.return = t),
      (r.return = t),
      (r.sibling = o),
      (t.child = r),
      (r = o),
      (o = t.child),
      (l = e.child.memoizedState),
      (l =
        l === null
          ? $s(n)
          : {
              baseLanes: l.baseLanes | n,
              cachePool: null,
              transitions: l.transitions,
            }),
      (o.memoizedState = l),
      (o.childLanes = e.childLanes & ~n),
      (t.memoizedState = Ps),
      r
    );
  }
  return (
    (o = e.child),
    (e = o.sibling),
    (r = en(o, { mode: "visible", children: r.children })),
    (t.mode & 1) === 0 && (r.lanes = n),
    (r.return = t),
    (r.sibling = null),
    e !== null &&
      ((n = t.deletions),
      n === null ? ((t.deletions = [e]), (t.flags |= 16)) : n.push(e)),
    (t.child = r),
    (t.memoizedState = null),
    r
  );
}
function Oa(e, t) {
  return (
    (t = Do({ mode: "visible", children: t }, e.mode, 0, null)),
    (t.return = e),
    (e.child = t)
  );
}
function $i(e, t, n, r) {
  return (
    r !== null && va(r),
    qn(t, e.child, null, n),
    (e = Oa(t, t.pendingProps.children)),
    (e.flags |= 2),
    (t.memoizedState = null),
    e
  );
}
function rv(e, t, n, r, i, o, l) {
  if (n)
    return t.flags & 256
      ? ((t.flags &= -257), (r = _l(Error(R(422)))), $i(e, t, l, r))
      : t.memoizedState !== null
      ? ((t.child = e.child), (t.flags |= 128), null)
      : ((o = r.fallback),
        (i = t.mode),
        (r = Do({ mode: "visible", children: r.children }, i, 0, null)),
        (o = hn(o, i, l, null)),
        (o.flags |= 2),
        (r.return = t),
        (o.return = t),
        (r.sibling = o),
        (t.child = r),
        (t.mode & 1) !== 0 && qn(t, e.child, null, l),
        (t.child.memoizedState = $s(l)),
        (t.memoizedState = Ps),
        o);
  if ((t.mode & 1) === 0) return $i(e, t, l, null);
  if (i.data === "$!") {
    if (((r = i.nextSibling && i.nextSibling.dataset), r)) var a = r.dgst;
    return (r = a), (o = Error(R(419))), (r = _l(o, r, void 0)), $i(e, t, l, r);
  }
  if (((a = (l & e.childLanes) !== 0), Ge || a)) {
    if (((r = ke), r !== null)) {
      switch (l & -l) {
        case 4:
          i = 2;
          break;
        case 16:
          i = 8;
          break;
        case 64:
        case 128:
        case 256:
        case 512:
        case 1024:
        case 2048:
        case 4096:
        case 8192:
        case 16384:
        case 32768:
        case 65536:
        case 131072:
        case 262144:
        case 524288:
        case 1048576:
        case 2097152:
        case 4194304:
        case 8388608:
        case 16777216:
        case 33554432:
        case 67108864:
          i = 32;
          break;
        case 536870912:
          i = 268435456;
          break;
        default:
          i = 0;
      }
      (i = (i & (r.suspendedLanes | l)) !== 0 ? 0 : i),
        i !== 0 &&
          i !== o.retryLane &&
          ((o.retryLane = i), zt(e, i), wt(r, e, i, -1));
    }
    return Ia(), (r = _l(Error(R(421)))), $i(e, t, l, r);
  }
  return i.data === "$?"
    ? ((t.flags |= 128),
      (t.child = e.child),
      (t = vv.bind(null, e)),
      (i._reactRetry = t),
      null)
    : ((e = o.treeContext),
      (Je = Kt(i.nextSibling)),
      (tt = t),
      (fe = !0),
      (gt = null),
      e !== null &&
        ((st[at++] = Lt),
        (st[at++] = Ot),
        (st[at++] = gn),
        (Lt = e.id),
        (Ot = e.overflow),
        (gn = t)),
      (t = Oa(t, r.children)),
      (t.flags |= 4096),
      t);
}
function ic(e, t, n) {
  e.lanes |= t;
  var r = e.alternate;
  r !== null && (r.lanes |= t), ws(e.return, t, n);
}
function Ll(e, t, n, r, i) {
  var o = e.memoizedState;
  o === null
    ? (e.memoizedState = {
        isBackwards: t,
        rendering: null,
        renderingStartTime: 0,
        last: r,
        tail: n,
        tailMode: i,
      })
    : ((o.isBackwards = t),
      (o.rendering = null),
      (o.renderingStartTime = 0),
      (o.last = r),
      (o.tail = n),
      (o.tailMode = i));
}
function bd(e, t, n) {
  var r = t.pendingProps,
    i = r.revealOrder,
    o = r.tail;
  if ((De(e, t, r.children, n), (r = de.current), (r & 2) !== 0))
    (r = (r & 1) | 2), (t.flags |= 128);
  else {
    if (e !== null && (e.flags & 128) !== 0)
      e: for (e = t.child; e !== null; ) {
        if (e.tag === 13) e.memoizedState !== null && ic(e, n, t);
        else if (e.tag === 19) ic(e, n, t);
        else if (e.child !== null) {
          (e.child.return = e), (e = e.child);
          continue;
        }
        if (e === t) break e;
        for (; e.sibling === null; ) {
          if (e.return === null || e.return === t) break e;
          e = e.return;
        }
        (e.sibling.return = e.return), (e = e.sibling);
      }
    r &= 1;
  }
  if ((se(de, r), (t.mode & 1) === 0)) t.memoizedState = null;
  else
    switch (i) {
      case "forwards":
        for (n = t.child, i = null; n !== null; )
          (e = n.alternate),
            e !== null && ho(e) === null && (i = n),
            (n = n.sibling);
        (n = i),
          n === null
            ? ((i = t.child), (t.child = null))
            : ((i = n.sibling), (n.sibling = null)),
          Ll(t, !1, i, n, o);
        break;
      case "backwards":
        for (n = null, i = t.child, t.child = null; i !== null; ) {
          if (((e = i.alternate), e !== null && ho(e) === null)) {
            t.child = i;
            break;
          }
          (e = i.sibling), (i.sibling = n), (n = i), (i = e);
        }
        Ll(t, !0, n, null, o);
        break;
      case "together":
        Ll(t, !1, null, null, void 0);
        break;
      default:
        t.memoizedState = null;
    }
  return t.child;
}
function Wi(e, t) {
  (t.mode & 1) === 0 &&
    e !== null &&
    ((e.alternate = null), (t.alternate = null), (t.flags |= 2));
}
function Rt(e, t, n) {
  if (
    (e !== null && (t.dependencies = e.dependencies),
    (Sn |= t.lanes),
    (n & t.childLanes) === 0)
  )
    return null;
  if (e !== null && t.child !== e.child) throw Error(R(153));
  if (t.child !== null) {
    for (
      e = t.child, n = en(e, e.pendingProps), t.child = n, n.return = t;
      e.sibling !== null;

    )
      (e = e.sibling), (n = n.sibling = en(e, e.pendingProps)), (n.return = t);
    n.sibling = null;
  }
  return t.child;
}
function iv(e, t, n) {
  switch (t.tag) {
    case 3:
      Rd(t), Zn();
      break;
    case 5:
      cd(t);
      break;
    case 1:
      Xe(t.type) && so(t);
      break;
    case 4:
      Ca(t, t.stateNode.containerInfo);
      break;
    case 10:
      var r = t.type._context,
        i = t.memoizedProps.value;
      se(co, r._currentValue), (r._currentValue = i);
      break;
    case 13:
      if (((r = t.memoizedState), r !== null))
        return r.dehydrated !== null
          ? (se(de, de.current & 1), (t.flags |= 128), null)
          : (n & t.child.childLanes) !== 0
          ? Id(e, t, n)
          : (se(de, de.current & 1),
            (e = Rt(e, t, n)),
            e !== null ? e.sibling : null);
      se(de, de.current & 1);
      break;
    case 19:
      if (((r = (n & t.childLanes) !== 0), (e.flags & 128) !== 0)) {
        if (r) return bd(e, t, n);
        t.flags |= 128;
      }
      if (
        ((i = t.memoizedState),
        i !== null &&
          ((i.rendering = null), (i.tail = null), (i.lastEffect = null)),
        se(de, de.current),
        r)
      )
        break;
      return null;
    case 22:
    case 23:
      return (t.lanes = 0), Ad(e, t, n);
  }
  return Rt(e, t, n);
}
var Dd, _s, jd, Fd;
Dd = function (e, t) {
  for (var n = t.child; n !== null; ) {
    if (n.tag === 5 || n.tag === 6) e.appendChild(n.stateNode);
    else if (n.tag !== 4 && n.child !== null) {
      (n.child.return = n), (n = n.child);
      continue;
    }
    if (n === t) break;
    for (; n.sibling === null; ) {
      if (n.return === null || n.return === t) return;
      n = n.return;
    }
    (n.sibling.return = n.return), (n = n.sibling);
  }
};
_s = function () {};
jd = function (e, t, n, r) {
  var i = e.memoizedProps;
  if (i !== r) {
    (e = t.stateNode), dn(Pt.current);
    var o = null;
    switch (n) {
      case "input":
        (i = Kl(e, i)), (r = Kl(e, r)), (o = []);
        break;
      case "select":
        (i = he({}, i, { value: void 0 })),
          (r = he({}, r, { value: void 0 })),
          (o = []);
        break;
      case "textarea":
        (i = Jl(e, i)), (r = Jl(e, r)), (o = []);
        break;
      default:
        typeof i.onClick != "function" &&
          typeof r.onClick == "function" &&
          (e.onclick = oo);
    }
    ts(n, r);
    var l;
    n = null;
    for (u in i)
      if (!r.hasOwnProperty(u) && i.hasOwnProperty(u) && i[u] != null)
        if (u === "style") {
          var a = i[u];
          for (l in a) a.hasOwnProperty(l) && (n || (n = {}), (n[l] = ""));
        } else
          u !== "dangerouslySetInnerHTML" &&
            u !== "children" &&
            u !== "suppressContentEditableWarning" &&
            u !== "suppressHydrationWarning" &&
            u !== "autoFocus" &&
            (Vr.hasOwnProperty(u)
              ? o || (o = [])
              : (o = o || []).push(u, null));
    for (u in r) {
      var s = r[u];
      if (
        ((a = i != null ? i[u] : void 0),
        r.hasOwnProperty(u) && s !== a && (s != null || a != null))
      )
        if (u === "style")
          if (a) {
            for (l in a)
              !a.hasOwnProperty(l) ||
                (s && s.hasOwnProperty(l)) ||
                (n || (n = {}), (n[l] = ""));
            for (l in s)
              s.hasOwnProperty(l) &&
                a[l] !== s[l] &&
                (n || (n = {}), (n[l] = s[l]));
          } else n || (o || (o = []), o.push(u, n)), (n = s);
        else
          u === "dangerouslySetInnerHTML"
            ? ((s = s ? s.__html : void 0),
              (a = a ? a.__html : void 0),
              s != null && a !== s && (o = o || []).push(u, s))
            : u === "children"
            ? (typeof s != "string" && typeof s != "number") ||
              (o = o || []).push(u, "" + s)
            : u !== "suppressContentEditableWarning" &&
              u !== "suppressHydrationWarning" &&
              (Vr.hasOwnProperty(u)
                ? (s != null && u === "onScroll" && ue("scroll", e),
                  o || a === s || (o = []))
                : (o = o || []).push(u, s));
    }
    n && (o = o || []).push("style", n);
    var u = o;
    (t.updateQueue = u) && (t.flags |= 4);
  }
};
Fd = function (e, t, n, r) {
  n !== r && (t.flags |= 4);
};
function Er(e, t) {
  if (!fe)
    switch (e.tailMode) {
      case "hidden":
        t = e.tail;
        for (var n = null; t !== null; )
          t.alternate !== null && (n = t), (t = t.sibling);
        n === null ? (e.tail = null) : (n.sibling = null);
        break;
      case "collapsed":
        n = e.tail;
        for (var r = null; n !== null; )
          n.alternate !== null && (r = n), (n = n.sibling);
        r === null
          ? t || e.tail === null
            ? (e.tail = null)
            : (e.tail.sibling = null)
          : (r.sibling = null);
    }
}
function Re(e) {
  var t = e.alternate !== null && e.alternate.child === e.child,
    n = 0,
    r = 0;
  if (t)
    for (var i = e.child; i !== null; )
      (n |= i.lanes | i.childLanes),
        (r |= i.subtreeFlags & 14680064),
        (r |= i.flags & 14680064),
        (i.return = e),
        (i = i.sibling);
  else
    for (i = e.child; i !== null; )
      (n |= i.lanes | i.childLanes),
        (r |= i.subtreeFlags),
        (r |= i.flags),
        (i.return = e),
        (i = i.sibling);
  return (e.subtreeFlags |= r), (e.childLanes = n), t;
}
function ov(e, t, n) {
  var r = t.pendingProps;
  switch ((ma(t), t.tag)) {
    case 2:
    case 16:
    case 15:
    case 0:
    case 11:
    case 7:
    case 8:
    case 12:
    case 9:
    case 14:
      return Re(t), null;
    case 1:
      return Xe(t.type) && lo(), Re(t), null;
    case 3:
      return (
        (r = t.stateNode),
        Jn(),
        ce(Ye),
        ce(be),
        Ta(),
        r.pendingContext &&
          ((r.context = r.pendingContext), (r.pendingContext = null)),
        (e === null || e.child === null) &&
          (ki(t)
            ? (t.flags |= 4)
            : e === null ||
              (e.memoizedState.isDehydrated && (t.flags & 256) === 0) ||
              ((t.flags |= 1024), gt !== null && (Is(gt), (gt = null)))),
        _s(e, t),
        Re(t),
        null
      );
    case 5:
      Ea(t);
      var i = dn(ei.current);
      if (((n = t.type), e !== null && t.stateNode != null))
        jd(e, t, n, r, i),
          e.ref !== t.ref && ((t.flags |= 512), (t.flags |= 2097152));
      else {
        if (!r) {
          if (t.stateNode === null) throw Error(R(166));
          return Re(t), null;
        }
        if (((e = dn(Pt.current)), ki(t))) {
          (r = t.stateNode), (n = t.type);
          var o = t.memoizedProps;
          switch (((r[Tt] = t), (r[qr] = o), (e = (t.mode & 1) !== 0), n)) {
            case "dialog":
              ue("cancel", r), ue("close", r);
              break;
            case "iframe":
            case "object":
            case "embed":
              ue("load", r);
              break;
            case "video":
            case "audio":
              for (i = 0; i < Lr.length; i++) ue(Lr[i], r);
              break;
            case "source":
              ue("error", r);
              break;
            // case "img":
            case "image":
            case "link":
              ue("error", r), ue("load", r);
              break;
            case "details":
              ue("toggle", r);
              break;
            case "input":
              pu(r, o), ue("invalid", r);
              break;
            case "select":
              (r._wrapperState = { wasMultiple: !!o.multiple }),
                ue("invalid", r);
              break;
            case "textarea":
              mu(r, o), ue("invalid", r);
          }
          ts(n, o), (i = null);
          for (var l in o)
            if (o.hasOwnProperty(l)) {
              var a = o[l];
              l === "children"
                ? typeof a == "string"
                  ? r.textContent !== a &&
                    (o.suppressHydrationWarning !== !0 &&
                      Ti(r.textContent, a, e),
                    (i = ["children", a]))
                  : typeof a == "number" &&
                    r.textContent !== "" + a &&
                    (o.suppressHydrationWarning !== !0 &&
                      Ti(r.textContent, a, e),
                    (i = ["children", "" + a]))
                : Vr.hasOwnProperty(l) &&
                  a != null &&
                  l === "onScroll" &&
                  ue("scroll", r);
            }
          switch (n) {
            case "input":
              vi(r), hu(r, o, !0);
              break;
            case "textarea":
              vi(r), vu(r);
              break;
            case "select":
            case "option":
              break;
            default:
              typeof o.onClick == "function" && (r.onclick = oo);
          }
          (r = i), (t.updateQueue = r), r !== null && (t.flags |= 4);
        } else {
          (l = i.nodeType === 9 ? i : i.ownerDocument),
            e === "http://www.w3.org/1999/xhtml" && (e = pf(n)),
            e === "http://www.w3.org/1999/xhtml"
              ? n === "script"
                ? ((e = l.createElement("div")),
                  (e.innerHTML = "<script></script>"),
                  (e = e.removeChild(e.firstChild)))
                : typeof r.is == "string"
                ? (e = l.createElement(n, { is: r.is }))
                : ((e = l.createElement(n)),
                  n === "select" &&
                    ((l = e),
                    r.multiple
                      ? (l.multiple = !0)
                      : r.size && (l.size = r.size)))
              : (e = l.createElementNS(e, n)),
            (e[Tt] = t),
            (e[qr] = r),
            Dd(e, t, !1, !1),
            (t.stateNode = e);
          e: {
            switch (((l = ns(n, r)), n)) {
              case "dialog":
                ue("cancel", e), ue("close", e), (i = r);
                break;
              case "iframe":
              case "object":
              case "embed":
                ue("load", e), (i = r);
                break;
              case "video":
              case "audio":
                for (i = 0; i < Lr.length; i++) ue(Lr[i], e);
                i = r;
                break;
              case "source":
                ue("error", e), (i = r);
                break;
              // case "img":
              case "image":
              case "link":
                ue("error", e), ue("load", e), (i = r);
                break;
              case "details":
                ue("toggle", e), (i = r);
                break;
              case "input":
                pu(e, r), (i = Kl(e, r)), ue("invalid", e);
                break;
              case "option":
                i = r;
                break;
              case "select":
                (e._wrapperState = { wasMultiple: !!r.multiple }),
                  (i = he({}, r, { value: void 0 })),
                  ue("invalid", e);
                break;
              case "textarea":
                mu(e, r), (i = Jl(e, r)), ue("invalid", e);
                break;
              default:
                i = r;
            }
            ts(n, i), (a = i);
            for (o in a)
              if (a.hasOwnProperty(o)) {
                var s = a[o];
                o === "style"
                  ? vf(e, s)
                  : o === "dangerouslySetInnerHTML"
                  ? ((s = s ? s.__html : void 0), s != null && hf(e, s))
                  : o === "children"
                  ? typeof s == "string"
                    ? (n !== "textarea" || s !== "") && Hr(e, s)
                    : typeof s == "number" && Hr(e, "" + s)
                  : o !== "suppressContentEditableWarning" &&
                    o !== "suppressHydrationWarning" &&
                    o !== "autoFocus" &&
                    (Vr.hasOwnProperty(o)
                      ? s != null && o === "onScroll" && ue("scroll", e)
                      : s != null && ea(e, o, s, l));
              }
            switch (n) {
              case "input":
                vi(e), hu(e, r, !1);
                break;
              case "textarea":
                vi(e), vu(e);
                break;
              case "option":
                r.value != null && e.setAttribute("value", "" + nn(r.value));
                break;
              case "select":
                (e.multiple = !!r.multiple),
                  (o = r.value),
                  o != null
                    ? Hn(e, !!r.multiple, o, !1)
                    : r.defaultValue != null &&
                      Hn(e, !!r.multiple, r.defaultValue, !0);
                break;
              default:
                typeof i.onClick == "function" && (e.onclick = oo);
            }
            switch (n) {
              case "button":
              case "input":
              case "select":
              case "textarea":
                r = !!r.autoFocus;
                break e;
              // case "img":
              //   r = !0;
              //   break e;
              default:
                r = !1;
            }
          }
          r && (t.flags |= 4);
        }
        t.ref !== null && ((t.flags |= 512), (t.flags |= 2097152));
      }
      return Re(t), null;
    case 6:
      if (e && t.stateNode != null) Fd(e, t, e.memoizedProps, r);
      else {
        if (typeof r != "string" && t.stateNode === null) throw Error(R(166));
        if (((n = dn(ei.current)), dn(Pt.current), ki(t))) {
          if (
            ((r = t.stateNode),
            (n = t.memoizedProps),
            (r[Tt] = t),
            (o = r.nodeValue !== n) && ((e = tt), e !== null))
          )
            switch (e.tag) {
              case 3:
                Ti(r.nodeValue, n, (e.mode & 1) !== 0);
                break;
              case 5:
                e.memoizedProps.suppressHydrationWarning !== !0 &&
                  Ti(r.nodeValue, n, (e.mode & 1) !== 0);
            }
          o && (t.flags |= 4);
        } else
          (r = (n.nodeType === 9 ? n : n.ownerDocument).createTextNode(r)),
            (r[Tt] = t),
            (t.stateNode = r);
      }
      return Re(t), null;
    case 13:
      if (
        (ce(de),
        (r = t.memoizedState),
        e === null ||
          (e.memoizedState !== null && e.memoizedState.dehydrated !== null))
      ) {
        if (fe && Je !== null && (t.mode & 1) !== 0 && (t.flags & 128) === 0)
          rd(), Zn(), (t.flags |= 98560), (o = !1);
        else if (((o = ki(t)), r !== null && r.dehydrated !== null)) {
          if (e === null) {
            if (!o) throw Error(R(318));
            if (
              ((o = t.memoizedState),
              (o = o !== null ? o.dehydrated : null),
              !o)
            )
              throw Error(R(317));
            o[Tt] = t;
          } else
            Zn(),
              (t.flags & 128) === 0 && (t.memoizedState = null),
              (t.flags |= 4);
          Re(t), (o = !1);
        } else gt !== null && (Is(gt), (gt = null)), (o = !0);
        if (!o) return t.flags & 65536 ? t : null;
      }
      return (t.flags & 128) !== 0
        ? ((t.lanes = n), t)
        : ((r = r !== null),
          r !== (e !== null && e.memoizedState !== null) &&
            r &&
            ((t.child.flags |= 8192),
            (t.mode & 1) !== 0 &&
              (e === null || (de.current & 1) !== 0
                ? xe === 0 && (xe = 3)
                : Ia())),
          t.updateQueue !== null && (t.flags |= 4),
          Re(t),
          null);
    case 4:
      return (
        Jn(), _s(e, t), e === null && Kr(t.stateNode.containerInfo), Re(t), null
      );
    case 10:
      return Sa(t.type._context), Re(t), null;
    case 17:
      return Xe(t.type) && lo(), Re(t), null;
    case 19:
      if ((ce(de), (o = t.memoizedState), o === null)) return Re(t), null;
      if (((r = (t.flags & 128) !== 0), (l = o.rendering), l === null))
        if (r) Er(o, !1);
        else {
          if (xe !== 0 || (e !== null && (e.flags & 128) !== 0))
            for (e = t.child; e !== null; ) {
              if (((l = ho(e)), l !== null)) {
                for (
                  t.flags |= 128,
                    Er(o, !1),
                    r = l.updateQueue,
                    r !== null && ((t.updateQueue = r), (t.flags |= 4)),
                    t.subtreeFlags = 0,
                    r = n,
                    n = t.child;
                  n !== null;

                )
                  (o = n),
                    (e = r),
                    (o.flags &= 14680066),
                    (l = o.alternate),
                    l === null
                      ? ((o.childLanes = 0),
                        (o.lanes = e),
                        (o.child = null),
                        (o.subtreeFlags = 0),
                        (o.memoizedProps = null),
                        (o.memoizedState = null),
                        (o.updateQueue = null),
                        (o.dependencies = null),
                        (o.stateNode = null))
                      : ((o.childLanes = l.childLanes),
                        (o.lanes = l.lanes),
                        (o.child = l.child),
                        (o.subtreeFlags = 0),
                        (o.deletions = null),
                        (o.memoizedProps = l.memoizedProps),
                        (o.memoizedState = l.memoizedState),
                        (o.updateQueue = l.updateQueue),
                        (o.type = l.type),
                        (e = l.dependencies),
                        (o.dependencies =
                          e === null
                            ? null
                            : {
                                lanes: e.lanes,
                                firstContext: e.firstContext,
                              })),
                    (n = n.sibling);
                return se(de, (de.current & 1) | 2), t.child;
              }
              e = e.sibling;
            }
          o.tail !== null &&
            ye() > tr &&
            ((t.flags |= 128), (r = !0), Er(o, !1), (t.lanes = 4194304));
        }
      else {
        if (!r)
          if (((e = ho(l)), e !== null)) {
            if (
              ((t.flags |= 128),
              (r = !0),
              (n = e.updateQueue),
              n !== null && ((t.updateQueue = n), (t.flags |= 4)),
              Er(o, !0),
              o.tail === null && o.tailMode === "hidden" && !l.alternate && !fe)
            )
              return Re(t), null;
          } else
            2 * ye() - o.renderingStartTime > tr &&
              n !== 1073741824 &&
              ((t.flags |= 128), (r = !0), Er(o, !1), (t.lanes = 4194304));
        o.isBackwards
          ? ((l.sibling = t.child), (t.child = l))
          : ((n = o.last),
            n !== null ? (n.sibling = l) : (t.child = l),
            (o.last = l));
      }
      return o.tail !== null
        ? ((t = o.tail),
          (o.rendering = t),
          (o.tail = t.sibling),
          (o.renderingStartTime = ye()),
          (t.sibling = null),
          (n = de.current),
          se(de, r ? (n & 1) | 2 : n & 1),
          t)
        : (Re(t), null);
    case 22:
    case 23:
      return (
        Ra(),
        (r = t.memoizedState !== null),
        e !== null && (e.memoizedState !== null) !== r && (t.flags |= 8192),
        r && (t.mode & 1) !== 0
          ? (Ke & 1073741824) !== 0 &&
            (Re(t), t.subtreeFlags & 6 && (t.flags |= 8192))
          : Re(t),
        null
      );
    case 24:
      return null;
    case 25:
      return null;
  }
  throw Error(R(156, t.tag));
}
function lv(e, t) {
  switch ((ma(t), t.tag)) {
    case 1:
      return (
        Xe(t.type) && lo(),
        (e = t.flags),
        e & 65536 ? ((t.flags = (e & -65537) | 128), t) : null
      );
    case 3:
      return (
        Jn(),
        ce(Ye),
        ce(be),
        Ta(),
        (e = t.flags),
        (e & 65536) !== 0 && (e & 128) === 0
          ? ((t.flags = (e & -65537) | 128), t)
          : null
      );
    case 5:
      return Ea(t), null;
    case 13:
      if (
        (ce(de), (e = t.memoizedState), e !== null && e.dehydrated !== null)
      ) {
        if (t.alternate === null) throw Error(R(340));
        Zn();
      }
      return (
        (e = t.flags), e & 65536 ? ((t.flags = (e & -65537) | 128), t) : null
      );
    case 19:
      return ce(de), null;
    case 4:
      return Jn(), null;
    case 10:
      return Sa(t.type._context), null;
    case 22:
    case 23:
      return Ra(), null;
    case 24:
      return null;
    default:
      return null;
  }
}
var _i = !1,
  Ie = !1,
  sv = typeof WeakSet == "function" ? WeakSet : Set,
  V = null;
function Fn(e, t) {
  var n = e.ref;
  if (n !== null)
    if (typeof n == "function")
      try {
        n(null);
      } catch (r) {
        ve(e, t, r);
      }
    else n.current = null;
}
function Ls(e, t, n) {
  try {
    n();
  } catch (r) {
    ve(e, t, r);
  }
}
var oc = !1;
function av(e, t) {
  if (((ds = no), (e = Uf()), pa(e))) {
    if ("selectionStart" in e)
      var n = { start: e.selectionStart, end: e.selectionEnd };
    else
      e: {
        n = ((n = e.ownerDocument) && n.defaultView) || window;
        var r = n.getSelection && n.getSelection();
        if (r && r.rangeCount !== 0) {
          n = r.anchorNode;
          var i = r.anchorOffset,
            o = r.focusNode;
          r = r.focusOffset;
          try {
            n.nodeType, o.nodeType;
          } catch {
            n = null;
            break e;
          }
          var l = 0,
            a = -1,
            s = -1,
            u = 0,
            c = 0,
            f = e,
            d = null;
          t: for (;;) {
            for (
              var v;
              f !== n || (i !== 0 && f.nodeType !== 3) || (a = l + i),
                f !== o || (r !== 0 && f.nodeType !== 3) || (s = l + r),
                f.nodeType === 3 && (l += f.nodeValue.length),
                (v = f.firstChild) !== null;

            )
              (d = f), (f = v);
            for (;;) {
              if (f === e) break t;
              if (
                (d === n && ++u === i && (a = l),
                d === o && ++c === r && (s = l),
                (v = f.nextSibling) !== null)
              )
                break;
              (f = d), (d = f.parentNode);
            }
            f = v;
          }
          n = a === -1 || s === -1 ? null : { start: a, end: s };
        } else n = null;
      }
    n = n || { start: 0, end: 0 };
  } else n = null;
  for (ps = { focusedElem: e, selectionRange: n }, no = !1, V = t; V !== null; )
    if (((t = V), (e = t.child), (t.subtreeFlags & 1028) !== 0 && e !== null))
      (e.return = t), (V = e);
    else
      for (; V !== null; ) {
        t = V;
        try {
          var g = t.alternate;
          if ((t.flags & 1024) !== 0)
            switch (t.tag) {
              case 0:
              case 11:
              case 15:
                break;
              case 1:
                if (g !== null) {
                  var y = g.memoizedProps,
                    x = g.memoizedState,
                    h = t.stateNode,
                    p = h.getSnapshotBeforeUpdate(
                      t.elementType === t.type ? y : mt(t.type, y),
                      x
                    );
                  h.__reactInternalSnapshotBeforeUpdate = p;
                }
                break;
              case 3:
                var m = t.stateNode.containerInfo;
                m.nodeType === 1
                  ? (m.textContent = "")
                  : m.nodeType === 9 &&
                    m.documentElement &&
                    m.removeChild(m.documentElement);
                break;
              case 5:
              case 6:
              case 4:
              case 17:
                break;
              default:
                throw Error(R(163));
            }
        } catch (S) {
          ve(t, t.return, S);
        }
        if (((e = t.sibling), e !== null)) {
          (e.return = t.return), (V = e);
          break;
        }
        V = t.return;
      }
  return (g = oc), (oc = !1), g;
}
function Ir(e, t, n) {
  var r = t.updateQueue;
  if (((r = r !== null ? r.lastEffect : null), r !== null)) {
    var i = (r = r.next);
    do {
      if ((i.tag & e) === e) {
        var o = i.destroy;
        (i.destroy = void 0), o !== void 0 && Ls(t, n, o);
      }
      i = i.next;
    } while (i !== r);
  }
}
function Io(e, t) {
  if (
    ((t = t.updateQueue), (t = t !== null ? t.lastEffect : null), t !== null)
  ) {
    var n = (t = t.next);
    do {
      if ((n.tag & e) === e) {
        var r = n.create;
        n.destroy = r();
      }
      n = n.next;
    } while (n !== t);
  }
}
function Os(e) {
  var t = e.ref;
  if (t !== null) {
    var n = e.stateNode;
    switch (e.tag) {
      case 5:
        e = n;
        break;
      default:
        e = n;
    }
    typeof t == "function" ? t(e) : (t.current = e);
  }
}
function Bd(e) {
  var t = e.alternate;
  t !== null && ((e.alternate = null), Bd(t)),
    (e.child = null),
    (e.deletions = null),
    (e.sibling = null),
    e.tag === 5 &&
      ((t = e.stateNode),
      t !== null &&
        (delete t[Tt], delete t[qr], delete t[vs], delete t[Um], delete t[Wm])),
    (e.stateNode = null),
    (e.return = null),
    (e.dependencies = null),
    (e.memoizedProps = null),
    (e.memoizedState = null),
    (e.pendingProps = null),
    (e.stateNode = null),
    (e.updateQueue = null);
}
function Vd(e) {
  return e.tag === 5 || e.tag === 3 || e.tag === 4;
}
function lc(e) {
  e: for (;;) {
    for (; e.sibling === null; ) {
      if (e.return === null || Vd(e.return)) return null;
      e = e.return;
    }
    for (
      e.sibling.return = e.return, e = e.sibling;
      e.tag !== 5 && e.tag !== 6 && e.tag !== 18;

    ) {
      if (e.flags & 2 || e.child === null || e.tag === 4) continue e;
      (e.child.return = e), (e = e.child);
    }
    if (!(e.flags & 2)) return e.stateNode;
  }
}
function Ms(e, t, n) {
  var r = e.tag;
  if (r === 5 || r === 6)
    (e = e.stateNode),
      t
        ? n.nodeType === 8
          ? n.parentNode.insertBefore(e, t)
          : n.insertBefore(e, t)
        : (n.nodeType === 8
            ? ((t = n.parentNode), t.insertBefore(e, n))
            : ((t = n), t.appendChild(e)),
          (n = n._reactRootContainer),
          n != null || t.onclick !== null || (t.onclick = oo));
  else if (r !== 4 && ((e = e.child), e !== null))
    for (Ms(e, t, n), e = e.sibling; e !== null; ) Ms(e, t, n), (e = e.sibling);
}
function Ns(e, t, n) {
  var r = e.tag;
  if (r === 5 || r === 6)
    (e = e.stateNode), t ? n.insertBefore(e, t) : n.appendChild(e);
  else if (r !== 4 && ((e = e.child), e !== null))
    for (Ns(e, t, n), e = e.sibling; e !== null; ) Ns(e, t, n), (e = e.sibling);
}
var Oe = null,
  vt = !1;
function Dt(e, t, n) {
  for (n = n.child; n !== null; ) Hd(e, t, n), (n = n.sibling);
}
function Hd(e, t, n) {
  if (kt && typeof kt.onCommitFiberUnmount == "function")
    try {
      kt.onCommitFiberUnmount(_o, n);
    } catch {}
  switch (n.tag) {
    case 5:
      Ie || Fn(n, t);
    case 6:
      var r = Oe,
        i = vt;
      (Oe = null),
        Dt(e, t, n),
        (Oe = r),
        (vt = i),
        Oe !== null &&
          (vt
            ? ((e = Oe),
              (n = n.stateNode),
              e.nodeType === 8 ? e.parentNode.removeChild(n) : e.removeChild(n))
            : Oe.removeChild(n.stateNode));
      break;
    case 18:
      Oe !== null &&
        (vt
          ? ((e = Oe),
            (n = n.stateNode),
            e.nodeType === 8
              ? Cl(e.parentNode, n)
              : e.nodeType === 1 && Cl(e, n),
            Yr(e))
          : Cl(Oe, n.stateNode));
      break;
    case 4:
      (r = Oe),
        (i = vt),
        (Oe = n.stateNode.containerInfo),
        (vt = !0),
        Dt(e, t, n),
        (Oe = r),
        (vt = i);
      break;
    case 0:
    case 11:
    case 14:
    case 15:
      if (
        !Ie &&
        ((r = n.updateQueue), r !== null && ((r = r.lastEffect), r !== null))
      ) {
        i = r = r.next;
        do {
          var o = i,
            l = o.destroy;
          (o = o.tag),
            l !== void 0 && ((o & 2) !== 0 || (o & 4) !== 0) && Ls(n, t, l),
            (i = i.next);
        } while (i !== r);
      }
      Dt(e, t, n);
      break;
    case 1:
      if (
        !Ie &&
        (Fn(n, t),
        (r = n.stateNode),
        typeof r.componentWillUnmount == "function")
      )
        try {
          (r.props = n.memoizedProps),
            (r.state = n.memoizedState),
            r.componentWillUnmount();
        } catch (a) {
          ve(n, t, a);
        }
      Dt(e, t, n);
      break;
    case 21:
      Dt(e, t, n);
      break;
    case 22:
      n.mode & 1
        ? ((Ie = (r = Ie) || n.memoizedState !== null), Dt(e, t, n), (Ie = r))
        : Dt(e, t, n);
      break;
    default:
      Dt(e, t, n);
  }
}
function sc(e) {
  var t = e.updateQueue;
  if (t !== null) {
    e.updateQueue = null;
    var n = e.stateNode;
    n === null && (n = e.stateNode = new sv()),
      t.forEach(function (r) {
        var i = gv.bind(null, e, r);
        n.has(r) || (n.add(r), r.then(i, i));
      });
  }
}
function ht(e, t) {
  var n = t.deletions;
  if (n !== null)
    for (var r = 0; r < n.length; r++) {
      var i = n[r];
      try {
        var o = e,
          l = t,
          a = l;
        e: for (; a !== null; ) {
          switch (a.tag) {
            case 5:
              (Oe = a.stateNode), (vt = !1);
              break e;
            case 3:
              (Oe = a.stateNode.containerInfo), (vt = !0);
              break e;
            case 4:
              (Oe = a.stateNode.containerInfo), (vt = !0);
              break e;
          }
          a = a.return;
        }
        if (Oe === null) throw Error(R(160));
        Hd(o, l, i), (Oe = null), (vt = !1);
        var s = i.alternate;
        s !== null && (s.return = null), (i.return = null);
      } catch (u) {
        ve(i, t, u);
      }
    }
  if (t.subtreeFlags & 12854)
    for (t = t.child; t !== null; ) Ud(t, e), (t = t.sibling);
}
function Ud(e, t) {
  var n = e.alternate,
    r = e.flags;
  switch (e.tag) {
    case 0:
    case 11:
    case 14:
    case 15:
      if ((ht(t, e), Ct(e), r & 4)) {
        try {
          Ir(3, e, e.return), Io(3, e);
        } catch (y) {
          ve(e, e.return, y);
        }
        try {
          Ir(5, e, e.return);
        } catch (y) {
          ve(e, e.return, y);
        }
      }
      break;
    case 1:
      ht(t, e), Ct(e), r & 512 && n !== null && Fn(n, n.return);
      break;
    case 5:
      if (
        (ht(t, e),
        Ct(e),
        r & 512 && n !== null && Fn(n, n.return),
        e.flags & 32)
      ) {
        var i = e.stateNode;
        try {
          Hr(i, "");
        } catch (y) {
          ve(e, e.return, y);
        }
      }
      if (r & 4 && ((i = e.stateNode), i != null)) {
        var o = e.memoizedProps,
          l = n !== null ? n.memoizedProps : o,
          a = e.type,
          s = e.updateQueue;
        if (((e.updateQueue = null), s !== null))
          try {
            a === "input" && o.type === "radio" && o.name != null && ff(i, o),
              ns(a, l);
            var u = ns(a, o);
            for (l = 0; l < s.length; l += 2) {
              var c = s[l],
                f = s[l + 1];
              c === "style"
                ? vf(i, f)
                : c === "dangerouslySetInnerHTML"
                ? hf(i, f)
                : c === "children"
                ? Hr(i, f)
                : ea(i, c, f, u);
            }
            switch (a) {
              case "input":
                Zl(i, o);
                break;
              case "textarea":
                df(i, o);
                break;
              case "select":
                var d = i._wrapperState.wasMultiple;
                i._wrapperState.wasMultiple = !!o.multiple;
                var v = o.value;
                v != null
                  ? Hn(i, !!o.multiple, v, !1)
                  : d !== !!o.multiple &&
                    (o.defaultValue != null
                      ? Hn(i, !!o.multiple, o.defaultValue, !0)
                      : Hn(i, !!o.multiple, o.multiple ? [] : "", !1));
            }
            i[qr] = o;
          } catch (y) {
            ve(e, e.return, y);
          }
      }
      break;
    case 6:
      if ((ht(t, e), Ct(e), r & 4)) {
        if (e.stateNode === null) throw Error(R(162));
        (i = e.stateNode), (o = e.memoizedProps);
        try {
          i.nodeValue = o;
        } catch (y) {
          ve(e, e.return, y);
        }
      }
      break;
    case 3:
      if (
        (ht(t, e), Ct(e), r & 4 && n !== null && n.memoizedState.isDehydrated)
      )
        try {
          Yr(t.containerInfo);
        } catch (y) {
          ve(e, e.return, y);
        }
      break;
    case 4:
      ht(t, e), Ct(e);
      break;
    case 13:
      ht(t, e),
        Ct(e),
        (i = e.child),
        i.flags & 8192 &&
          ((o = i.memoizedState !== null),
          (i.stateNode.isHidden = o),
          !o ||
            (i.alternate !== null && i.alternate.memoizedState !== null) ||
            (Aa = ye())),
        r & 4 && sc(e);
      break;
    case 22:
      if (
        ((c = n !== null && n.memoizedState !== null),
        e.mode & 1 ? ((Ie = (u = Ie) || c), ht(t, e), (Ie = u)) : ht(t, e),
        Ct(e),
        r & 8192)
      ) {
        if (
          ((u = e.memoizedState !== null),
          (e.stateNode.isHidden = u) && !c && (e.mode & 1) !== 0)
        )
          for (V = e, c = e.child; c !== null; ) {
            for (f = V = c; V !== null; ) {
              switch (((d = V), (v = d.child), d.tag)) {
                case 0:
                case 11:
                case 14:
                case 15:
                  Ir(4, d, d.return);
                  break;
                case 1:
                  Fn(d, d.return);
                  var g = d.stateNode;
                  if (typeof g.componentWillUnmount == "function") {
                    (r = d), (n = d.return);
                    try {
                      (t = r),
                        (g.props = t.memoizedProps),
                        (g.state = t.memoizedState),
                        g.componentWillUnmount();
                    } catch (y) {
                      ve(r, n, y);
                    }
                  }
                  break;
                case 5:
                  Fn(d, d.return);
                  break;
                case 22:
                  if (d.memoizedState !== null) {
                    uc(f);
                    continue;
                  }
              }
              v !== null ? ((v.return = d), (V = v)) : uc(f);
            }
            c = c.sibling;
          }
        e: for (c = null, f = e; ; ) {
          if (f.tag === 5) {
            if (c === null) {
              c = f;
              try {
                (i = f.stateNode),
                  u
                    ? ((o = i.style),
                      typeof o.setProperty == "function"
                        ? o.setProperty("display", "none", "important")
                        : (o.display = "none"))
                    : ((a = f.stateNode),
                      (s = f.memoizedProps.style),
                      (l =
                        s != null && s.hasOwnProperty("display")
                          ? s.display
                          : null),
                      (a.style.display = mf("display", l)));
              } catch (y) {
                ve(e, e.return, y);
              }
            }
          } else if (f.tag === 6) {
            if (c === null)
              try {
                f.stateNode.nodeValue = u ? "" : f.memoizedProps;
              } catch (y) {
                ve(e, e.return, y);
              }
          } else if (
            ((f.tag !== 22 && f.tag !== 23) ||
              f.memoizedState === null ||
              f === e) &&
            f.child !== null
          ) {
            (f.child.return = f), (f = f.child);
            continue;
          }
          if (f === e) break e;
          for (; f.sibling === null; ) {
            if (f.return === null || f.return === e) break e;
            c === f && (c = null), (f = f.return);
          }
          c === f && (c = null), (f.sibling.return = f.return), (f = f.sibling);
        }
      }
      break;
    case 19:
      ht(t, e), Ct(e), r & 4 && sc(e);
      break;
    case 21:
      break;
    default:
      ht(t, e), Ct(e);
  }
}
function Ct(e) {
  var t = e.flags;
  if (t & 2) {
    try {
      e: {
        for (var n = e.return; n !== null; ) {
          if (Vd(n)) {
            var r = n;
            break e;
          }
          n = n.return;
        }
        throw Error(R(160));
      }
      switch (r.tag) {
        case 5:
          var i = r.stateNode;
          r.flags & 32 && (Hr(i, ""), (r.flags &= -33));
          var o = lc(e);
          Ns(e, o, i);
          break;
        case 3:
        case 4:
          var l = r.stateNode.containerInfo,
            a = lc(e);
          Ms(e, a, l);
          break;
        default:
          throw Error(R(161));
      }
    } catch (s) {
      ve(e, e.return, s);
    }
    e.flags &= -3;
  }
  t & 4096 && (e.flags &= -4097);
}
function uv(e, t, n) {
  (V = e), Wd(e);
}
function Wd(e, t, n) {
  for (var r = (e.mode & 1) !== 0; V !== null; ) {
    var i = V,
      o = i.child;
    if (i.tag === 22 && r) {
      var l = i.memoizedState !== null || _i;
      if (!l) {
        var a = i.alternate,
          s = (a !== null && a.memoizedState !== null) || Ie;
        a = _i;
        var u = Ie;
        if (((_i = l), (Ie = s) && !u))
          for (V = i; V !== null; )
            (l = V),
              (s = l.child),
              l.tag === 22 && l.memoizedState !== null
                ? cc(i)
                : s !== null
                ? ((s.return = l), (V = s))
                : cc(i);
        for (; o !== null; ) (V = o), Wd(o), (o = o.sibling);
        (V = i), (_i = a), (Ie = u);
      }
      ac(e);
    } else
      (i.subtreeFlags & 8772) !== 0 && o !== null
        ? ((o.return = i), (V = o))
        : ac(e);
  }
}
function ac(e) {
  for (; V !== null; ) {
    var t = V;
    if ((t.flags & 8772) !== 0) {
      var n = t.alternate;
      try {
        if ((t.flags & 8772) !== 0)
          switch (t.tag) {
            case 0:
            case 11:
            case 15:
              Ie || Io(5, t);
              break;
            case 1:
              var r = t.stateNode;
              if (t.flags & 4 && !Ie)
                if (n === null) r.componentDidMount();
                else {
                  var i =
                    t.elementType === t.type
                      ? n.memoizedProps
                      : mt(t.type, n.memoizedProps);
                  r.componentDidUpdate(
                    i,
                    n.memoizedState,
                    r.__reactInternalSnapshotBeforeUpdate
                  );
                }
              var o = t.updateQueue;
              o !== null && Wu(t, o, r);
              break;
            case 3:
              var l = t.updateQueue;
              if (l !== null) {
                if (((n = null), t.child !== null))
                  switch (t.child.tag) {
                    case 5:
                      n = t.child.stateNode;
                      break;
                    case 1:
                      n = t.child.stateNode;
                  }
                Wu(t, l, n);
              }
              break;
            case 5:
              var a = t.stateNode;
              if (n === null && t.flags & 4) {
                n = a;
                var s = t.memoizedProps;
                switch (t.type) {
                  case "button":
                  case "input":
                  case "select":
                  case "textarea":
                    s.autoFocus && n.focus();
                    break;
                  // case "img":
                  //   s.src && (n.src = s.src);
                }
              }
              break;
            case 6:
              break;
            case 4:
              break;
            case 12:
              break;
            case 13:
              if (t.memoizedState === null) {
                var u = t.alternate;
                if (u !== null) {
                  var c = u.memoizedState;
                  if (c !== null) {
                    var f = c.dehydrated;
                    f !== null && Yr(f);
                  }
                }
              }
              break;
            case 19:
            case 17:
            case 21:
            case 22:
            case 23:
            case 25:
              break;
            default:
              throw Error(R(163));
          }
        Ie || (t.flags & 512 && Os(t));
      } catch (d) {
        ve(t, t.return, d);
      }
    }
    if (t === e) {
      V = null;
      break;
    }
    if (((n = t.sibling), n !== null)) {
      (n.return = t.return), (V = n);
      break;
    }
    V = t.return;
  }
}
function uc(e) {
  for (; V !== null; ) {
    var t = V;
    if (t === e) {
      V = null;
      break;
    }
    var n = t.sibling;
    if (n !== null) {
      (n.return = t.return), (V = n);
      break;
    }
    V = t.return;
  }
}
function cc(e) {
  for (; V !== null; ) {
    var t = V;
    try {
      switch (t.tag) {
        case 0:
        case 11:
        case 15:
          var n = t.return;
          try {
            Io(4, t);
          } catch (s) {
            ve(t, n, s);
          }
          break;
        case 1:
          var r = t.stateNode;
          if (typeof r.componentDidMount == "function") {
            var i = t.return;
            try {
              r.componentDidMount();
            } catch (s) {
              ve(t, i, s);
            }
          }
          var o = t.return;
          try {
            Os(t);
          } catch (s) {
            ve(t, o, s);
          }
          break;
        case 5:
          var l = t.return;
          try {
            Os(t);
          } catch (s) {
            ve(t, l, s);
          }
      }
    } catch (s) {
      ve(t, t.return, s);
    }
    if (t === e) {
      V = null;
      break;
    }
    var a = t.sibling;
    if (a !== null) {
      (a.return = t.return), (V = a);
      break;
    }
    V = t.return;
  }
}
var cv = Math.ceil,
  go = It.ReactCurrentDispatcher,
  Ma = It.ReactCurrentOwner,
  ct = It.ReactCurrentBatchConfig,
  ee = 0,
  ke = null,
  Se = null,
  Me = 0,
  Ke = 0,
  Bn = ln(0),
  xe = 0,
  ii = null,
  Sn = 0,
  bo = 0,
  Na = 0,
  br = null,
  We = null,
  Aa = 0,
  tr = 1 / 0,
  $t = null,
  yo = !1,
  As = null,
  qt = null,
  Li = !1,
  Ut = null,
  So = 0,
  Dr = 0,
  zs = null,
  Gi = -1,
  Yi = 0;
function Fe() {
  return (ee & 6) !== 0 ? ye() : Gi !== -1 ? Gi : (Gi = ye());
}
function Jt(e) {
  return (e.mode & 1) === 0
    ? 1
    : (ee & 2) !== 0 && Me !== 0
    ? Me & -Me
    : Ym.transition !== null
    ? (Yi === 0 && (Yi = _f()), Yi)
    : ((e = oe),
      e !== 0 || ((e = window.event), (e = e === void 0 ? 16 : Rf(e.type))),
      e);
}
function wt(e, t, n, r) {
  if (50 < Dr) throw ((Dr = 0), (zs = null), Error(R(185)));
  ai(e, n, r),
    ((ee & 2) === 0 || e !== ke) &&
      (e === ke && ((ee & 2) === 0 && (bo |= n), xe === 4 && Vt(e, Me)),
      Qe(e, r),
      n === 1 &&
        ee === 0 &&
        (t.mode & 1) === 0 &&
        ((tr = ye() + 500), Ao && sn()));
}
function Qe(e, t) {
  var n = e.callbackNode;
  Yh(e, t);
  var r = to(e, e === ke ? Me : 0);
  if (r === 0)
    n !== null && Su(n), (e.callbackNode = null), (e.callbackPriority = 0);
  else if (((t = r & -r), e.callbackPriority !== t)) {
    if ((n != null && Su(n), t === 1))
      e.tag === 0 ? Gm(fc.bind(null, e)) : ed(fc.bind(null, e)),
        Vm(function () {
          (ee & 6) === 0 && sn();
        }),
        (n = null);
    else {
      switch (Lf(r)) {
        case 1:
          n = oa;
          break;
        case 4:
          n = Pf;
          break;
        case 16:
          n = eo;
          break;
        case 536870912:
          n = $f;
          break;
        default:
          n = eo;
      }
      n = Jd(n, Gd.bind(null, e));
    }
    (e.callbackPriority = t), (e.callbackNode = n);
  }
}
function Gd(e, t) {
  if (((Gi = -1), (Yi = 0), (ee & 6) !== 0)) throw Error(R(327));
  var n = e.callbackNode;
  if (Xn() && e.callbackNode !== n) return null;
  var r = to(e, e === ke ? Me : 0);
  if (r === 0) return null;
  if ((r & 30) !== 0 || (r & e.expiredLanes) !== 0 || t) t = wo(e, r);
  else {
    t = r;
    var i = ee;
    ee |= 2;
    var o = Xd();
    (ke !== e || Me !== t) && (($t = null), (tr = ye() + 500), pn(e, t));
    do
      try {
        pv();
        break;
      } catch (a) {
        Yd(e, a);
      }
    while (1);
    ya(),
      (go.current = o),
      (ee = i),
      Se !== null ? (t = 0) : ((ke = null), (Me = 0), (t = xe));
  }
  if (t !== 0) {
    if (
      (t === 2 && ((i = ss(e)), i !== 0 && ((r = i), (t = Rs(e, i)))), t === 1)
    )
      throw ((n = ii), pn(e, 0), Vt(e, r), Qe(e, ye()), n);
    if (t === 6) Vt(e, r);
    else {
      if (
        ((i = e.current.alternate),
        (r & 30) === 0 &&
          !fv(i) &&
          ((t = wo(e, r)),
          t === 2 && ((o = ss(e)), o !== 0 && ((r = o), (t = Rs(e, o)))),
          t === 1))
      )
        throw ((n = ii), pn(e, 0), Vt(e, r), Qe(e, ye()), n);
      switch (((e.finishedWork = i), (e.finishedLanes = r), t)) {
        case 0:
        case 1:
          throw Error(R(345));
        case 2:
          un(e, We, $t);
          break;
        case 3:
          if (
            (Vt(e, r), (r & 130023424) === r && ((t = Aa + 500 - ye()), 10 < t))
          ) {
            if (to(e, 0) !== 0) break;
            if (((i = e.suspendedLanes), (i & r) !== r)) {
              Fe(), (e.pingedLanes |= e.suspendedLanes & i);
              break;
            }
            e.timeoutHandle = ms(un.bind(null, e, We, $t), t);
            break;
          }
          un(e, We, $t);
          break;
        case 4:
          if ((Vt(e, r), (r & 4194240) === r)) break;
          for (t = e.eventTimes, i = -1; 0 < r; ) {
            var l = 31 - St(r);
            (o = 1 << l), (l = t[l]), l > i && (i = l), (r &= ~o);
          }
          if (
            ((r = i),
            (r = ye() - r),
            (r =
              (120 > r
                ? 120
                : 480 > r
                ? 480
                : 1080 > r
                ? 1080
                : 1920 > r
                ? 1920
                : 3e3 > r
                ? 3e3
                : 4320 > r
                ? 4320
                : 1960 * cv(r / 1960)) - r),
            10 < r)
          ) {
            e.timeoutHandle = ms(un.bind(null, e, We, $t), r);
            break;
          }
          un(e, We, $t);
          break;
        case 5:
          un(e, We, $t);
          break;
        default:
          throw Error(R(329));
      }
    }
  }
  return Qe(e, ye()), e.callbackNode === n ? Gd.bind(null, e) : null;
}
function Rs(e, t) {
  var n = br;
  return (
    e.current.memoizedState.isDehydrated && (pn(e, t).flags |= 256),
    (e = wo(e, t)),
    e !== 2 && ((t = We), (We = n), t !== null && Is(t)),
    e
  );
}
function Is(e) {
  We === null ? (We = e) : We.push.apply(We, e);
}
function fv(e) {
  for (var t = e; ; ) {
    if (t.flags & 16384) {
      var n = t.updateQueue;
      if (n !== null && ((n = n.stores), n !== null))
        for (var r = 0; r < n.length; r++) {
          var i = n[r],
            o = i.getSnapshot;
          i = i.value;
          try {
            if (!xt(o(), i)) return !1;
          } catch {
            return !1;
          }
        }
    }
    if (((n = t.child), t.subtreeFlags & 16384 && n !== null))
      (n.return = t), (t = n);
    else {
      if (t === e) break;
      for (; t.sibling === null; ) {
        if (t.return === null || t.return === e) return !0;
        t = t.return;
      }
      (t.sibling.return = t.return), (t = t.sibling);
    }
  }
  return !0;
}
function Vt(e, t) {
  for (
    t &= ~Na,
      t &= ~bo,
      e.suspendedLanes |= t,
      e.pingedLanes &= ~t,
      e = e.expirationTimes;
    0 < t;

  ) {
    var n = 31 - St(t),
      r = 1 << n;
    (e[n] = -1), (t &= ~r);
  }
}
function fc(e) {
  if ((ee & 6) !== 0) throw Error(R(327));
  Xn();
  var t = to(e, 0);
  if ((t & 1) === 0) return Qe(e, ye()), null;
  var n = wo(e, t);
  if (e.tag !== 0 && n === 2) {
    var r = ss(e);
    r !== 0 && ((t = r), (n = Rs(e, r)));
  }
  if (n === 1) throw ((n = ii), pn(e, 0), Vt(e, t), Qe(e, ye()), n);
  if (n === 6) throw Error(R(345));
  return (
    (e.finishedWork = e.current.alternate),
    (e.finishedLanes = t),
    un(e, We, $t),
    Qe(e, ye()),
    null
  );
}
function za(e, t) {
  var n = ee;
  ee |= 1;
  try {
    return e(t);
  } finally {
    (ee = n), ee === 0 && ((tr = ye() + 500), Ao && sn());
  }
}
function wn(e) {
  Ut !== null && Ut.tag === 0 && (ee & 6) === 0 && Xn();
  var t = ee;
  ee |= 1;
  var n = ct.transition,
    r = oe;
  try {
    if (((ct.transition = null), (oe = 1), e)) return e();
  } finally {
    (oe = r), (ct.transition = n), (ee = t), (ee & 6) === 0 && sn();
  }
}
function Ra() {
  (Ke = Bn.current), ce(Bn);
}
function pn(e, t) {
  (e.finishedWork = null), (e.finishedLanes = 0);
  var n = e.timeoutHandle;
  if ((n !== -1 && ((e.timeoutHandle = -1), Bm(n)), Se !== null))
    for (n = Se.return; n !== null; ) {
      var r = n;
      switch ((ma(r), r.tag)) {
        case 1:
          (r = r.type.childContextTypes), r != null && lo();
          break;
        case 3:
          Jn(), ce(Ye), ce(be), Ta();
          break;
        case 5:
          Ea(r);
          break;
        case 4:
          Jn();
          break;
        case 13:
          ce(de);
          break;
        case 19:
          ce(de);
          break;
        case 10:
          Sa(r.type._context);
          break;
        case 22:
        case 23:
          Ra();
      }
      n = n.return;
    }
  if (
    ((ke = e),
    (Se = e = en(e.current, null)),
    (Me = Ke = t),
    (xe = 0),
    (ii = null),
    (Na = bo = Sn = 0),
    (We = br = null),
    fn !== null)
  ) {
    for (t = 0; t < fn.length; t++)
      if (((n = fn[t]), (r = n.interleaved), r !== null)) {
        n.interleaved = null;
        var i = r.next,
          o = n.pending;
        if (o !== null) {
          var l = o.next;
          (o.next = i), (r.next = l);
        }
        n.pending = r;
      }
    fn = null;
  }
  return e;
}
function Yd(e, t) {
  do {
    var n = Se;
    try {
      if ((ya(), (Hi.current = vo), mo)) {
        for (var r = pe.memoizedState; r !== null; ) {
          var i = r.queue;
          i !== null && (i.pending = null), (r = r.next);
        }
        mo = !1;
      }
      if (
        ((yn = 0),
        (Ee = we = pe = null),
        (Rr = !1),
        (ti = 0),
        (Ma.current = null),
        n === null || n.return === null)
      ) {
        (xe = 1), (ii = t), (Se = null);
        break;
      }
      e: {
        var o = e,
          l = n.return,
          a = n,
          s = t;
        if (
          ((t = Me),
          (a.flags |= 32768),
          s !== null && typeof s == "object" && typeof s.then == "function")
        ) {
          var u = s,
            c = a,
            f = c.tag;
          if ((c.mode & 1) === 0 && (f === 0 || f === 11 || f === 15)) {
            var d = c.alternate;
            d
              ? ((c.updateQueue = d.updateQueue),
                (c.memoizedState = d.memoizedState),
                (c.lanes = d.lanes))
              : ((c.updateQueue = null), (c.memoizedState = null));
          }
          var v = qu(l);
          if (v !== null) {
            (v.flags &= -257),
              Ju(v, l, a, o, t),
              v.mode & 1 && Zu(o, u, t),
              (t = v),
              (s = u);
            var g = t.updateQueue;
            if (g === null) {
              var y = new Set();
              y.add(s), (t.updateQueue = y);
            } else g.add(s);
            break e;
          } else {
            if ((t & 1) === 0) {
              Zu(o, u, t), Ia();
              break e;
            }
            s = Error(R(426));
          }
        } else if (fe && a.mode & 1) {
          var x = qu(l);
          if (x !== null) {
            (x.flags & 65536) === 0 && (x.flags |= 256),
              Ju(x, l, a, o, t),
              va(er(s, a));
            break e;
          }
        }
        (o = s = er(s, a)),
          xe !== 4 && (xe = 2),
          br === null ? (br = [o]) : br.push(o),
          (o = l);
        do {
          switch (o.tag) {
            case 3:
              (o.flags |= 65536), (t &= -t), (o.lanes |= t);
              var h = Od(o, s, t);
              Uu(o, h);
              break e;
            case 1:
              a = s;
              var p = o.type,
                m = o.stateNode;
              if (
                (o.flags & 128) === 0 &&
                (typeof p.getDerivedStateFromError == "function" ||
                  (m !== null &&
                    typeof m.componentDidCatch == "function" &&
                    (qt === null || !qt.has(m))))
              ) {
                (o.flags |= 65536), (t &= -t), (o.lanes |= t);
                var S = Md(o, a, t);
                Uu(o, S);
                break e;
              }
          }
          o = o.return;
        } while (o !== null);
      }
      Kd(n);
    } catch (w) {
      (t = w), Se === n && n !== null && (Se = n = n.return);
      continue;
    }
    break;
  } while (1);
}
function Xd() {
  var e = go.current;
  return (go.current = vo), e === null ? vo : e;
}
function Ia() {
  (xe === 0 || xe === 3 || xe === 2) && (xe = 4),
    ke === null ||
      ((Sn & 268435455) === 0 && (bo & 268435455) === 0) ||
      Vt(ke, Me);
}
function wo(e, t) {
  var n = ee;
  ee |= 2;
  var r = Xd();
  (ke !== e || Me !== t) && (($t = null), pn(e, t));
  do
    try {
      dv();
      break;
    } catch (i) {
      Yd(e, i);
    }
  while (1);
  if ((ya(), (ee = n), (go.current = r), Se !== null)) throw Error(R(261));
  return (ke = null), (Me = 0), xe;
}
function dv() {
  for (; Se !== null; ) Qd(Se);
}
function pv() {
  for (; Se !== null && !Dh(); ) Qd(Se);
}
function Qd(e) {
  var t = qd(e.alternate, e, Ke);
  (e.memoizedProps = e.pendingProps),
    t === null ? Kd(e) : (Se = t),
    (Ma.current = null);
}
function Kd(e) {
  var t = e;
  do {
    var n = t.alternate;
    if (((e = t.return), (t.flags & 32768) === 0)) {
      if (((n = ov(n, t, Ke)), n !== null)) {
        Se = n;
        return;
      }
    } else {
      if (((n = lv(n, t)), n !== null)) {
        (n.flags &= 32767), (Se = n);
        return;
      }
      if (e !== null)
        (e.flags |= 32768), (e.subtreeFlags = 0), (e.deletions = null);
      else {
        (xe = 6), (Se = null);
        return;
      }
    }
    if (((t = t.sibling), t !== null)) {
      Se = t;
      return;
    }
    Se = t = e;
  } while (t !== null);
  xe === 0 && (xe = 5);
}
function un(e, t, n) {
  var r = oe,
    i = ct.transition;
  try {
    (ct.transition = null), (oe = 1), hv(e, t, n, r);
  } finally {
    (ct.transition = i), (oe = r);
  }
  return null;
}
function hv(e, t, n, r) {
  do Xn();
  while (Ut !== null);
  if ((ee & 6) !== 0) throw Error(R(327));
  n = e.finishedWork;
  var i = e.finishedLanes;
  if (n === null) return null;
  if (((e.finishedWork = null), (e.finishedLanes = 0), n === e.current))
    throw Error(R(177));
  (e.callbackNode = null), (e.callbackPriority = 0);
  var o = n.lanes | n.childLanes;
  if (
    (Xh(e, o),
    e === ke && ((Se = ke = null), (Me = 0)),
    ((n.subtreeFlags & 2064) === 0 && (n.flags & 2064) === 0) ||
      Li ||
      ((Li = !0),
      Jd(eo, function () {
        return Xn(), null;
      })),
    (o = (n.flags & 15990) !== 0),
    (n.subtreeFlags & 15990) !== 0 || o)
  ) {
    (o = ct.transition), (ct.transition = null);
    var l = oe;
    oe = 1;
    var a = ee;
    (ee |= 4),
      (Ma.current = null),
      av(e, n),
      Ud(n, e),
      zm(ps),
      (no = !!ds),
      (ps = ds = null),
      (e.current = n),
      uv(n),
      jh(),
      (ee = a),
      (oe = l),
      (ct.transition = o);
  } else e.current = n;
  if (
    (Li && ((Li = !1), (Ut = e), (So = i)),
    (o = e.pendingLanes),
    o === 0 && (qt = null),
    Vh(n.stateNode),
    Qe(e, ye()),
    t !== null)
  )
    for (r = e.onRecoverableError, n = 0; n < t.length; n++)
      (i = t[n]), r(i.value, { componentStack: i.stack, digest: i.digest });
  if (yo) throw ((yo = !1), (e = As), (As = null), e);
  return (
    (So & 1) !== 0 && e.tag !== 0 && Xn(),
    (o = e.pendingLanes),
    (o & 1) !== 0 ? (e === zs ? Dr++ : ((Dr = 0), (zs = e))) : (Dr = 0),
    sn(),
    null
  );
}
function Xn() {
  if (Ut !== null) {
    var e = Lf(So),
      t = ct.transition,
      n = oe;
    try {
      if (((ct.transition = null), (oe = 16 > e ? 16 : e), Ut === null))
        var r = !1;
      else {
        if (((e = Ut), (Ut = null), (So = 0), (ee & 6) !== 0))
          throw Error(R(331));
        var i = ee;
        for (ee |= 4, V = e.current; V !== null; ) {
          var o = V,
            l = o.child;
          if ((V.flags & 16) !== 0) {
            var a = o.deletions;
            if (a !== null) {
              for (var s = 0; s < a.length; s++) {
                var u = a[s];
                for (V = u; V !== null; ) {
                  var c = V;
                  switch (c.tag) {
                    case 0:
                    case 11:
                    case 15:
                      Ir(8, c, o);
                  }
                  var f = c.child;
                  if (f !== null) (f.return = c), (V = f);
                  else
                    for (; V !== null; ) {
                      c = V;
                      var d = c.sibling,
                        v = c.return;
                      if ((Bd(c), c === u)) {
                        V = null;
                        break;
                      }
                      if (d !== null) {
                        (d.return = v), (V = d);
                        break;
                      }
                      V = v;
                    }
                }
              }
              var g = o.alternate;
              if (g !== null) {
                var y = g.child;
                if (y !== null) {
                  g.child = null;
                  do {
                    var x = y.sibling;
                    (y.sibling = null), (y = x);
                  } while (y !== null);
                }
              }
              V = o;
            }
          }
          if ((o.subtreeFlags & 2064) !== 0 && l !== null)
            (l.return = o), (V = l);
          else
            e: for (; V !== null; ) {
              if (((o = V), (o.flags & 2048) !== 0))
                switch (o.tag) {
                  case 0:
                  case 11:
                  case 15:
                    Ir(9, o, o.return);
                }
              var h = o.sibling;
              if (h !== null) {
                (h.return = o.return), (V = h);
                break e;
              }
              V = o.return;
            }
        }
        var p = e.current;
        for (V = p; V !== null; ) {
          l = V;
          var m = l.child;
          if ((l.subtreeFlags & 2064) !== 0 && m !== null)
            (m.return = l), (V = m);
          else
            e: for (l = p; V !== null; ) {
              if (((a = V), (a.flags & 2048) !== 0))
                try {
                  switch (a.tag) {
                    case 0:
                    case 11:
                    case 15:
                      Io(9, a);
                  }
                } catch (w) {
                  ve(a, a.return, w);
                }
              if (a === l) {
                V = null;
                break e;
              }
              var S = a.sibling;
              if (S !== null) {
                (S.return = a.return), (V = S);
                break e;
              }
              V = a.return;
            }
        }
        if (
          ((ee = i), sn(), kt && typeof kt.onPostCommitFiberRoot == "function")
        )
          try {
            kt.onPostCommitFiberRoot(_o, e);
          } catch {}
        r = !0;
      }
      return r;
    } finally {
      (oe = n), (ct.transition = t);
    }
  }
  return !1;
}
function dc(e, t, n) {
  (t = er(n, t)),
    (t = Od(e, t, 1)),
    (e = Zt(e, t, 1)),
    (t = Fe()),
    e !== null && (ai(e, 1, t), Qe(e, t));
}
function ve(e, t, n) {
  if (e.tag === 3) dc(e, e, n);
  else
    for (; t !== null; ) {
      if (t.tag === 3) {
        dc(t, e, n);
        break;
      } else if (t.tag === 1) {
        var r = t.stateNode;
        if (
          typeof t.type.getDerivedStateFromError == "function" ||
          (typeof r.componentDidCatch == "function" &&
            (qt === null || !qt.has(r)))
        ) {
          (e = er(n, e)),
            (e = Md(t, e, 1)),
            (t = Zt(t, e, 1)),
            (e = Fe()),
            t !== null && (ai(t, 1, e), Qe(t, e));
          break;
        }
      }
      t = t.return;
    }
}
function mv(e, t, n) {
  var r = e.pingCache;
  r !== null && r.delete(t),
    (t = Fe()),
    (e.pingedLanes |= e.suspendedLanes & n),
    ke === e &&
      (Me & n) === n &&
      (xe === 4 || (xe === 3 && (Me & 130023424) === Me && 500 > ye() - Aa)
        ? pn(e, 0)
        : (Na |= n)),
    Qe(e, t);
}
function Zd(e, t) {
  t === 0 &&
    ((e.mode & 1) === 0
      ? (t = 1)
      : ((t = Si), (Si <<= 1), (Si & 130023424) === 0 && (Si = 4194304)));
  var n = Fe();
  (e = zt(e, t)), e !== null && (ai(e, t, n), Qe(e, n));
}
function vv(e) {
  var t = e.memoizedState,
    n = 0;
  t !== null && (n = t.retryLane), Zd(e, n);
}
function gv(e, t) {
  var n = 0;
  switch (e.tag) {
    case 13:
      var r = e.stateNode,
        i = e.memoizedState;
      i !== null && (n = i.retryLane);
      break;
    case 19:
      r = e.stateNode;
      break;
    default:
      throw Error(R(314));
  }
  r !== null && r.delete(t), Zd(e, n);
}
var qd;
qd = function (e, t, n) {
  if (e !== null)
    if (e.memoizedProps !== t.pendingProps || Ye.current) Ge = !0;
    else {
      if ((e.lanes & n) === 0 && (t.flags & 128) === 0)
        return (Ge = !1), iv(e, t, n);
      Ge = (e.flags & 131072) !== 0;
    }
  else (Ge = !1), fe && (t.flags & 1048576) !== 0 && td(t, uo, t.index);
  switch (((t.lanes = 0), t.tag)) {
    case 2:
      var r = t.type;
      Wi(e, t), (e = t.pendingProps);
      var i = Kn(t, be.current);
      Yn(t, n), (i = Pa(null, t, r, e, i, n));
      var o = $a();
      return (
        (t.flags |= 1),
        typeof i == "object" &&
        i !== null &&
        typeof i.render == "function" &&
        i.$$typeof === void 0
          ? ((t.tag = 1),
            (t.memoizedState = null),
            (t.updateQueue = null),
            Xe(r) ? ((o = !0), so(t)) : (o = !1),
            (t.memoizedState =
              i.state !== null && i.state !== void 0 ? i.state : null),
            xa(t),
            (i.updater = zo),
            (t.stateNode = i),
            (i._reactInternals = t),
            Cs(t, r, e, n),
            (t = ks(null, t, r, !0, o, n)))
          : ((t.tag = 0), fe && o && ha(t), De(null, t, i, n), (t = t.child)),
        t
      );
    case 16:
      r = t.elementType;
      e: {
        switch (
          (Wi(e, t),
          (e = t.pendingProps),
          (i = r._init),
          (r = i(r._payload)),
          (t.type = r),
          (i = t.tag = Sv(r)),
          (e = mt(r, e)),
          i)
        ) {
          case 0:
            t = Ts(null, t, r, e, n);
            break e;
          case 1:
            t = nc(null, t, r, e, n);
            break e;
          case 11:
            t = ec(null, t, r, e, n);
            break e;
          case 14:
            t = tc(null, t, r, mt(r.type, e), n);
            break e;
        }
        throw Error(R(306, r, ""));
      }
      return t;
    case 0:
      return (
        (r = t.type),
        (i = t.pendingProps),
        (i = t.elementType === r ? i : mt(r, i)),
        Ts(e, t, r, i, n)
      );
    case 1:
      return (
        (r = t.type),
        (i = t.pendingProps),
        (i = t.elementType === r ? i : mt(r, i)),
        nc(e, t, r, i, n)
      );
    case 3:
      e: {
        if ((Rd(t), e === null)) throw Error(R(387));
        (r = t.pendingProps),
          (o = t.memoizedState),
          (i = o.element),
          od(e, t),
          po(t, r, null, n);
        var l = t.memoizedState;
        if (((r = l.element), o.isDehydrated))
          if (
            ((o = {
              element: r,
              isDehydrated: !1,
              cache: l.cache,
              pendingSuspenseBoundaries: l.pendingSuspenseBoundaries,
              transitions: l.transitions,
            }),
            (t.updateQueue.baseState = o),
            (t.memoizedState = o),
            t.flags & 256)
          ) {
            (i = er(Error(R(423)), t)), (t = rc(e, t, r, n, i));
            break e;
          } else if (r !== i) {
            (i = er(Error(R(424)), t)), (t = rc(e, t, r, n, i));
            break e;
          } else
            for (
              Je = Kt(t.stateNode.containerInfo.firstChild),
                tt = t,
                fe = !0,
                gt = null,
                n = ud(t, null, r, n),
                t.child = n;
              n;

            )
              (n.flags = (n.flags & -3) | 4096), (n = n.sibling);
        else {
          if ((Zn(), r === i)) {
            t = Rt(e, t, n);
            break e;
          }
          De(e, t, r, n);
        }
        t = t.child;
      }
      return t;
    case 5:
      return (
        cd(t),
        e === null && Ss(t),
        (r = t.type),
        (i = t.pendingProps),
        (o = e !== null ? e.memoizedProps : null),
        (l = i.children),
        hs(r, i) ? (l = null) : o !== null && hs(r, o) && (t.flags |= 32),
        zd(e, t),
        De(e, t, l, n),
        t.child
      );
    case 6:
      return e === null && Ss(t), null;
    case 13:
      return Id(e, t, n);
    case 4:
      return (
        Ca(t, t.stateNode.containerInfo),
        (r = t.pendingProps),
        e === null ? (t.child = qn(t, null, r, n)) : De(e, t, r, n),
        t.child
      );
    case 11:
      return (
        (r = t.type),
        (i = t.pendingProps),
        (i = t.elementType === r ? i : mt(r, i)),
        ec(e, t, r, i, n)
      );
    case 7:
      return De(e, t, t.pendingProps, n), t.child;
    case 8:
      return De(e, t, t.pendingProps.children, n), t.child;
    case 12:
      return De(e, t, t.pendingProps.children, n), t.child;
    case 10:
      e: {
        if (
          ((r = t.type._context),
          (i = t.pendingProps),
          (o = t.memoizedProps),
          (l = i.value),
          se(co, r._currentValue),
          (r._currentValue = l),
          o !== null)
        )
          if (xt(o.value, l)) {
            if (o.children === i.children && !Ye.current) {
              t = Rt(e, t, n);
              break e;
            }
          } else
            for (o = t.child, o !== null && (o.return = t); o !== null; ) {
              var a = o.dependencies;
              if (a !== null) {
                l = o.child;
                for (var s = a.firstContext; s !== null; ) {
                  if (s.context === r) {
                    if (o.tag === 1) {
                      (s = Mt(-1, n & -n)), (s.tag = 2);
                      var u = o.updateQueue;
                      if (u !== null) {
                        u = u.shared;
                        var c = u.pending;
                        c === null
                          ? (s.next = s)
                          : ((s.next = c.next), (c.next = s)),
                          (u.pending = s);
                      }
                    }
                    (o.lanes |= n),
                      (s = o.alternate),
                      s !== null && (s.lanes |= n),
                      ws(o.return, n, t),
                      (a.lanes |= n);
                    break;
                  }
                  s = s.next;
                }
              } else if (o.tag === 10) l = o.type === t.type ? null : o.child;
              else if (o.tag === 18) {
                if (((l = o.return), l === null)) throw Error(R(341));
                (l.lanes |= n),
                  (a = l.alternate),
                  a !== null && (a.lanes |= n),
                  ws(l, n, t),
                  (l = o.sibling);
              } else l = o.child;
              if (l !== null) l.return = o;
              else
                for (l = o; l !== null; ) {
                  if (l === t) {
                    l = null;
                    break;
                  }
                  if (((o = l.sibling), o !== null)) {
                    (o.return = l.return), (l = o);
                    break;
                  }
                  l = l.return;
                }
              o = l;
            }
        De(e, t, i.children, n), (t = t.child);
      }
      return t;
    case 9:
      return (
        (i = t.type),
        (r = t.pendingProps.children),
        Yn(t, n),
        (i = ft(i)),
        (r = r(i)),
        (t.flags |= 1),
        De(e, t, r, n),
        t.child
      );
    case 14:
      return (
        (r = t.type),
        (i = mt(r, t.pendingProps)),
        (i = mt(r.type, i)),
        tc(e, t, r, i, n)
      );
    case 15:
      return Nd(e, t, t.type, t.pendingProps, n);
    case 17:
      return (
        (r = t.type),
        (i = t.pendingProps),
        (i = t.elementType === r ? i : mt(r, i)),
        Wi(e, t),
        (t.tag = 1),
        Xe(r) ? ((e = !0), so(t)) : (e = !1),
        Yn(t, n),
        sd(t, r, i),
        Cs(t, r, i, n),
        ks(null, t, r, !0, e, n)
      );
    case 19:
      return bd(e, t, n);
    case 22:
      return Ad(e, t, n);
  }
  throw Error(R(156, t.tag));
};
function Jd(e, t) {
  return kf(e, t);
}
function yv(e, t, n, r) {
  (this.tag = e),
    (this.key = n),
    (this.sibling =
      this.child =
      this.return =
      this.stateNode =
      this.type =
      this.elementType =
        null),
    (this.index = 0),
    (this.ref = null),
    (this.pendingProps = t),
    (this.dependencies =
      this.memoizedState =
      this.updateQueue =
      this.memoizedProps =
        null),
    (this.mode = r),
    (this.subtreeFlags = this.flags = 0),
    (this.deletions = null),
    (this.childLanes = this.lanes = 0),
    (this.alternate = null);
}
function ut(e, t, n, r) {
  return new yv(e, t, n, r);
}
function ba(e) {
  return (e = e.prototype), !(!e || !e.isReactComponent);
}
function Sv(e) {
  if (typeof e == "function") return ba(e) ? 1 : 0;
  if (e != null) {
    if (((e = e.$$typeof), e === na)) return 11;
    if (e === ra) return 14;
  }
  return 2;
}
function en(e, t) {
  var n = e.alternate;
  return (
    n === null
      ? ((n = ut(e.tag, t, e.key, e.mode)),
        (n.elementType = e.elementType),
        (n.type = e.type),
        (n.stateNode = e.stateNode),
        (n.alternate = e),
        (e.alternate = n))
      : ((n.pendingProps = t),
        (n.type = e.type),
        (n.flags = 0),
        (n.subtreeFlags = 0),
        (n.deletions = null)),
    (n.flags = e.flags & 14680064),
    (n.childLanes = e.childLanes),
    (n.lanes = e.lanes),
    (n.child = e.child),
    (n.memoizedProps = e.memoizedProps),
    (n.memoizedState = e.memoizedState),
    (n.updateQueue = e.updateQueue),
    (t = e.dependencies),
    (n.dependencies =
      t === null ? null : { lanes: t.lanes, firstContext: t.firstContext }),
    (n.sibling = e.sibling),
    (n.index = e.index),
    (n.ref = e.ref),
    n
  );
}
function Xi(e, t, n, r, i, o) {
  var l = 2;
  if (((r = e), typeof e == "function")) ba(e) && (l = 1);
  else if (typeof e == "string") l = 5;
  else
    e: switch (e) {
      case Mn:
        return hn(n.children, i, o, t);
      case ta:
        (l = 8), (i |= 8);
        break;
      case Gl:
        return (
          (e = ut(12, n, t, i | 2)), (e.elementType = Gl), (e.lanes = o), e
        );
      case Yl:
        return (e = ut(13, n, t, i)), (e.elementType = Yl), (e.lanes = o), e;
      case Xl:
        return (e = ut(19, n, t, i)), (e.elementType = Xl), (e.lanes = o), e;
      case af:
        return Do(n, i, o, t);
      default:
        if (typeof e == "object" && e !== null)
          switch (e.$$typeof) {
            case lf:
              l = 10;
              break e;
            case sf:
              l = 9;
              break e;
            case na:
              l = 11;
              break e;
            case ra:
              l = 14;
              break e;
            case jt:
              (l = 16), (r = null);
              break e;
          }
        throw Error(R(130, e == null ? e : typeof e, ""));
    }
  return (
    (t = ut(l, n, t, i)), (t.elementType = e), (t.type = r), (t.lanes = o), t
  );
}
function hn(e, t, n, r) {
  return (e = ut(7, e, r, t)), (e.lanes = n), e;
}
function Do(e, t, n, r) {
  return (
    (e = ut(22, e, r, t)),
    (e.elementType = af),
    (e.lanes = n),
    (e.stateNode = { isHidden: !1 }),
    e
  );
}
function Ol(e, t, n) {
  return (e = ut(6, e, null, t)), (e.lanes = n), e;
}
function Ml(e, t, n) {
  return (
    (t = ut(4, e.children !== null ? e.children : [], e.key, t)),
    (t.lanes = n),
    (t.stateNode = {
      containerInfo: e.containerInfo,
      pendingChildren: null,
      implementation: e.implementation,
    }),
    t
  );
}
function wv(e, t, n, r, i) {
  (this.tag = t),
    (this.containerInfo = e),
    (this.finishedWork =
      this.pingCache =
      this.current =
      this.pendingChildren =
        null),
    (this.timeoutHandle = -1),
    (this.callbackNode = this.pendingContext = this.context = null),
    (this.callbackPriority = 0),
    (this.eventTimes = fl(0)),
    (this.expirationTimes = fl(-1)),
    (this.entangledLanes =
      this.finishedLanes =
      this.mutableReadLanes =
      this.expiredLanes =
      this.pingedLanes =
      this.suspendedLanes =
      this.pendingLanes =
        0),
    (this.entanglements = fl(0)),
    (this.identifierPrefix = r),
    (this.onRecoverableError = i),
    (this.mutableSourceEagerHydrationData = null);
}
function Da(e, t, n, r, i, o, l, a, s) {
  return (
    (e = new wv(e, t, n, a, s)),
    t === 1 ? ((t = 1), o === !0 && (t |= 8)) : (t = 0),
    (o = ut(3, null, null, t)),
    (e.current = o),
    (o.stateNode = e),
    (o.memoizedState = {
      element: r,
      isDehydrated: n,
      cache: null,
      transitions: null,
      pendingSuspenseBoundaries: null,
    }),
    xa(o),
    e
  );
}
function xv(e, t, n) {
  var r = 3 < arguments.length && arguments[3] !== void 0 ? arguments[3] : null;
  return {
    $$typeof: On,
    key: r == null ? null : "" + r,
    children: e,
    containerInfo: t,
    implementation: n,
  };
}
function ep(e) {
  if (!e) return rn;
  e = e._reactInternals;
  e: {
    if ($n(e) !== e || e.tag !== 1) throw Error(R(170));
    var t = e;
    do {
      switch (t.tag) {
        case 3:
          t = t.stateNode.context;
          break e;
        case 1:
          if (Xe(t.type)) {
            t = t.stateNode.__reactInternalMemoizedMergedChildContext;
            break e;
          }
      }
      t = t.return;
    } while (t !== null);
    throw Error(R(171));
  }
  if (e.tag === 1) {
    var n = e.type;
    if (Xe(n)) return Jf(e, n, t);
  }
  return t;
}
function tp(e, t, n, r, i, o, l, a, s) {
  return (
    (e = Da(n, r, !0, e, i, o, l, a, s)),
    (e.context = ep(null)),
    (n = e.current),
    (r = Fe()),
    (i = Jt(n)),
    (o = Mt(r, i)),
    (o.callback = t != null ? t : null),
    Zt(n, o, i),
    (e.current.lanes = i),
    ai(e, i, r),
    Qe(e, r),
    e
  );
}
function jo(e, t, n, r) {
  var i = t.current,
    o = Fe(),
    l = Jt(i);
  return (
    (n = ep(n)),
    t.context === null ? (t.context = n) : (t.pendingContext = n),
    (t = Mt(o, l)),
    (t.payload = { element: e }),
    (r = r === void 0 ? null : r),
    r !== null && (t.callback = r),
    (e = Zt(i, t, l)),
    e !== null && (wt(e, i, l, o), Vi(e, i, l)),
    l
  );
}
function xo(e) {
  if (((e = e.current), !e.child)) return null;
  switch (e.child.tag) {
    case 5:
      return e.child.stateNode;
    default:
      return e.child.stateNode;
  }
}
function pc(e, t) {
  if (((e = e.memoizedState), e !== null && e.dehydrated !== null)) {
    var n = e.retryLane;
    e.retryLane = n !== 0 && n < t ? n : t;
  }
}
function ja(e, t) {
  pc(e, t), (e = e.alternate) && pc(e, t);
}
function Cv() {
  return null;
}
var np =
  typeof reportError == "function"
    ? reportError
    : function (e) {
        console.error(e);
      };
function Fa(e) {
  this._internalRoot = e;
}
Fo.prototype.render = Fa.prototype.render = function (e) {
  var t = this._internalRoot;
  if (t === null) throw Error(R(409));
  jo(e, t, null, null);
};
Fo.prototype.unmount = Fa.prototype.unmount = function () {
  var e = this._internalRoot;
  if (e !== null) {
    this._internalRoot = null;
    var t = e.containerInfo;
    wn(function () {
      jo(null, e, null, null);
    }),
      (t[At] = null);
  }
};
function Fo(e) {
  this._internalRoot = e;
}
Fo.prototype.unstable_scheduleHydration = function (e) {
  if (e) {
    var t = Nf();
    e = { blockedOn: null, target: e, priority: t };
    for (var n = 0; n < Bt.length && t !== 0 && t < Bt[n].priority; n++);
    Bt.splice(n, 0, e), n === 0 && zf(e);
  }
};
function Ba(e) {
  return !(!e || (e.nodeType !== 1 && e.nodeType !== 9 && e.nodeType !== 11));
}
function Bo(e) {
  return !(
    !e ||
    (e.nodeType !== 1 &&
      e.nodeType !== 9 &&
      e.nodeType !== 11 &&
      (e.nodeType !== 8 || e.nodeValue !== " react-mount-point-unstable "))
  );
}
function hc() {}
function Ev(e, t, n, r, i) {
  if (i) {
    if (typeof r == "function") {
      var o = r;
      r = function () {
        var u = xo(l);
        o.call(u);
      };
    }
    var l = tp(t, r, e, 0, null, !1, !1, "", hc);
    return (
      (e._reactRootContainer = l),
      (e[At] = l.current),
      Kr(e.nodeType === 8 ? e.parentNode : e),
      wn(),
      l
    );
  }
  for (; (i = e.lastChild); ) e.removeChild(i);
  if (typeof r == "function") {
    var a = r;
    r = function () {
      var u = xo(s);
      a.call(u);
    };
  }
  var s = Da(e, 0, !1, null, null, !1, !1, "", hc);
  return (
    (e._reactRootContainer = s),
    (e[At] = s.current),
    Kr(e.nodeType === 8 ? e.parentNode : e),
    wn(function () {
      jo(t, s, n, r);
    }),
    s
  );
}
function Vo(e, t, n, r, i) {
  var o = n._reactRootContainer;
  if (o) {
    var l = o;
    if (typeof i == "function") {
      var a = i;
      i = function () {
        var s = xo(l);
        a.call(s);
      };
    }
    jo(t, l, e, i);
  } else l = Ev(n, t, e, i, r);
  return xo(l);
}
Of = function (e) {
  switch (e.tag) {
    case 3:
      var t = e.stateNode;
      if (t.current.memoizedState.isDehydrated) {
        var n = _r(t.pendingLanes);
        n !== 0 &&
          (la(t, n | 1),
          Qe(t, ye()),
          (ee & 6) === 0 && ((tr = ye() + 500), sn()));
      }
      break;
    case 13:
      wn(function () {
        var r = zt(e, 1);
        if (r !== null) {
          var i = Fe();
          wt(r, e, 1, i);
        }
      }),
        ja(e, 1);
  }
};
sa = function (e) {
  if (e.tag === 13) {
    var t = zt(e, 134217728);
    if (t !== null) {
      var n = Fe();
      wt(t, e, 134217728, n);
    }
    ja(e, 134217728);
  }
};
Mf = function (e) {
  if (e.tag === 13) {
    var t = Jt(e),
      n = zt(e, t);
    if (n !== null) {
      var r = Fe();
      wt(n, e, t, r);
    }
    ja(e, t);
  }
};
Nf = function () {
  return oe;
};
Af = function (e, t) {
  var n = oe;
  try {
    return (oe = e), t();
  } finally {
    oe = n;
  }
};
is = function (e, t, n) {
  switch (t) {
    case "input":
      if ((Zl(e, n), (t = n.name), n.type === "radio" && t != null)) {
        for (n = e; n.parentNode; ) n = n.parentNode;
        for (
          n = n.querySelectorAll(
            "input[name=" + JSON.stringify("" + t) + '][type="radio"]'
          ),
            t = 0;
          t < n.length;
          t++
        ) {
          var r = n[t];
          if (r !== e && r.form === e.form) {
            var i = No(r);
            if (!i) throw Error(R(90));
            cf(r), Zl(r, i);
          }
        }
      }
      break;
    case "textarea":
      df(e, n);
      break;
    case "select":
      (t = n.value), t != null && Hn(e, !!n.multiple, t, !1);
  }
};
Sf = za;
wf = wn;
var Tv = { usingClientEntryPoint: !1, Events: [ci, Rn, No, gf, yf, za] },
  Tr = {
    findFiberByHostInstance: cn,
    bundleType: 0,
    version: "18.2.0",
    rendererPackageName: "react-dom",
  },
  kv = {
    bundleType: Tr.bundleType,
    version: Tr.version,
    rendererPackageName: Tr.rendererPackageName,
    rendererConfig: Tr.rendererConfig,
    overrideHookState: null,
    overrideHookStateDeletePath: null,
    overrideHookStateRenamePath: null,
    overrideProps: null,
    overridePropsDeletePath: null,
    overridePropsRenamePath: null,
    setErrorHandler: null,
    setSuspenseHandler: null,
    scheduleUpdate: null,
    currentDispatcherRef: It.ReactCurrentDispatcher,
    findHostInstanceByFiber: function (e) {
      return (e = Ef(e)), e === null ? null : e.stateNode;
    },
    findFiberByHostInstance: Tr.findFiberByHostInstance || Cv,
    findHostInstancesForRefresh: null,
    scheduleRefresh: null,
    scheduleRoot: null,
    setRefreshHandler: null,
    getCurrentFiber: null,
    reconcilerVersion: "18.2.0-next-9e3b772b8-20220608",
  };
if (typeof __REACT_DEVTOOLS_GLOBAL_HOOK__ != "undefined") {
  var Oi = __REACT_DEVTOOLS_GLOBAL_HOOK__;
  if (!Oi.isDisabled && Oi.supportsFiber)
    try {
      (_o = Oi.inject(kv)), (kt = Oi);
    } catch {}
}
rt.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = Tv;
rt.createPortal = function (e, t) {
  var n = 2 < arguments.length && arguments[2] !== void 0 ? arguments[2] : null;
  if (!Ba(t)) throw Error(R(200));
  return xv(e, t, null, n);
};
rt.createRoot = function (e, t) {
  if (!Ba(e)) throw Error(R(299));
  var n = !1,
    r = "",
    i = np;
  return (
    t != null &&
      (t.unstable_strictMode === !0 && (n = !0),
      t.identifierPrefix !== void 0 && (r = t.identifierPrefix),
      t.onRecoverableError !== void 0 && (i = t.onRecoverableError)),
    (t = Da(e, 1, !1, null, null, n, !1, r, i)),
    (e[At] = t.current),
    Kr(e.nodeType === 8 ? e.parentNode : e),
    new Fa(t)
  );
};
rt.findDOMNode = function (e) {
  if (e == null) return null;
  if (e.nodeType === 1) return e;
  var t = e._reactInternals;
  if (t === void 0)
    throw typeof e.render == "function"
      ? Error(R(188))
      : ((e = Object.keys(e).join(",")), Error(R(268, e)));
  return (e = Ef(t)), (e = e === null ? null : e.stateNode), e;
};
rt.flushSync = function (e) {
  return wn(e);
};
rt.hydrate = function (e, t, n) {
  if (!Bo(t)) throw Error(R(200));
  return Vo(null, e, t, !0, n);
};
rt.hydrateRoot = function (e, t, n) {
  if (!Ba(e)) throw Error(R(405));
  var r = (n != null && n.hydratedSources) || null,
    i = !1,
    o = "",
    l = np;
  if (
    (n != null &&
      (n.unstable_strictMode === !0 && (i = !0),
      n.identifierPrefix !== void 0 && (o = n.identifierPrefix),
      n.onRecoverableError !== void 0 && (l = n.onRecoverableError)),
    (t = tp(t, null, e, 1, n != null ? n : null, i, !1, o, l)),
    (e[At] = t.current),
    Kr(e),
    r)
  )
    for (e = 0; e < r.length; e++)
      (n = r[e]),
        (i = n._getVersion),
        (i = i(n._source)),
        t.mutableSourceEagerHydrationData == null
          ? (t.mutableSourceEagerHydrationData = [n, i])
          : t.mutableSourceEagerHydrationData.push(n, i);
  return new Fo(t);
};
rt.render = function (e, t, n) {
  if (!Bo(t)) throw Error(R(200));
  return Vo(null, e, t, !1, n);
};
rt.unmountComponentAtNode = function (e) {
  if (!Bo(e)) throw Error(R(40));
  return e._reactRootContainer
    ? (wn(function () {
        Vo(null, null, e, !1, function () {
          (e._reactRootContainer = null), (e[At] = null);
        });
      }),
      !0)
    : !1;
};
rt.unstable_batchedUpdates = za;
rt.unstable_renderSubtreeIntoContainer = function (e, t, n, r) {
  if (!Bo(n)) throw Error(R(200));
  if (e == null || e._reactInternals === void 0) throw Error(R(38));
  return Vo(e, t, n, !1, r);
};
rt.version = "18.2.0-next-9e3b772b8-20220608";
function rp() {
  if (
    !(
      typeof __REACT_DEVTOOLS_GLOBAL_HOOK__ == "undefined" ||
      typeof __REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE != "function"
    )
  )
    try {
      __REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE(rp);
    } catch (e) {
      console.error(e);
    }
}
rp(), (Yc.exports = rt);
function bs(e, t) {
  return (
    (bs = Object.setPrototypeOf
      ? Object.setPrototypeOf.bind()
      : function (r, i) {
          return (r.__proto__ = i), r;
        }),
    bs(e, t)
  );
}
function dr(e, t) {
  (e.prototype = Object.create(t.prototype)),
    (e.prototype.constructor = e),
    bs(e, t);
}
var ip = { exports: {} },
  Pv = "SECRET_DO_NOT_PASS_THIS_OR_YOU_WILL_BE_FIRED",
  $v = Pv,
  _v = $v;
function op() {}
function lp() {}
lp.resetWarningCache = op;
var Lv = function () {
  function e(r, i, o, l, a, s) {
    if (s !== _v) {
      var u = new Error(
        "Calling PropTypes validators directly is not supported by the `prop-types` package. Use PropTypes.checkPropTypes() to call them. Read more at http://fb.me/use-check-prop-types"
      );
      throw ((u.name = "Invariant Violation"), u);
    }
  }
  e.isRequired = e;
  function t() {
    return e;
  }
  var n = {
    array: e,
    bigint: e,
    bool: e,
    func: e,
    number: e,
    object: e,
    string: e,
    symbol: e,
    any: e,
    arrayOf: t,
    element: e,
    elementType: e,
    instanceOf: t,
    node: e,
    objectOf: t,
    oneOf: t,
    oneOfType: t,
    shape: t,
    exact: t,
    checkPropTypes: lp,
    resetWarningCache: op,
  };
  return (n.PropTypes = n), n;
};
ip.exports = Lv();
var mc = ip.exports;
function nr() {
  return (
    (nr = Object.assign
      ? Object.assign.bind()
      : function (e) {
          for (var t = 1; t < arguments.length; t++) {
            var n = arguments[t];
            for (var r in n)
              Object.prototype.hasOwnProperty.call(n, r) && (e[r] = n[r]);
          }
          return e;
        }),
    nr.apply(this, arguments)
  );
}
function Mi(e) {
  return e.charAt(0) === "/";
}
function Nl(e, t) {
  for (var n = t, r = n + 1, i = e.length; r < i; n += 1, r += 1) e[n] = e[r];
  e.pop();
}
function Ov(e, t) {
  t === void 0 && (t = "");
  var n = (e && e.split("/")) || [],
    r = (t && t.split("/")) || [],
    i = e && Mi(e),
    o = t && Mi(t),
    l = i || o;
  if (
    (e && Mi(e) ? (r = n) : n.length && (r.pop(), (r = r.concat(n))), !r.length)
  )
    return "/";
  var a;
  if (r.length) {
    var s = r[r.length - 1];
    a = s === "." || s === ".." || s === "";
  } else a = !1;
  for (var u = 0, c = r.length; c >= 0; c--) {
    var f = r[c];
    f === "." ? Nl(r, c) : f === ".." ? (Nl(r, c), u++) : u && (Nl(r, c), u--);
  }
  if (!l) for (; u--; u) r.unshift("..");
  l && r[0] !== "" && (!r[0] || !Mi(r[0])) && r.unshift("");
  var d = r.join("/");
  return a && d.substr(-1) !== "/" && (d += "/"), d;
}
var Mv = !0,
  Al = "Invariant failed";
function _n(e, t) {
  if (!e) {
    if (Mv) throw new Error(Al);
    var n = typeof t == "function" ? t() : t,
      r = n ? "".concat(Al, ": ").concat(n) : Al;
    throw new Error(r);
  }
}
function jr(e) {
  return e.charAt(0) === "/" ? e : "/" + e;
}
function vc(e) {
  return e.charAt(0) === "/" ? e.substr(1) : e;
}
function Nv(e, t) {
  return (
    e.toLowerCase().indexOf(t.toLowerCase()) === 0 &&
    "/?#".indexOf(e.charAt(t.length)) !== -1
  );
}
function sp(e, t) {
  return Nv(e, t) ? e.substr(t.length) : e;
}
function ap(e) {
  return e.charAt(e.length - 1) === "/" ? e.slice(0, -1) : e;
}
function Av(e) {
  var t = e || "/",
    n = "",
    r = "",
    i = t.indexOf("#");
  i !== -1 && ((r = t.substr(i)), (t = t.substr(0, i)));
  var o = t.indexOf("?");
  return (
    o !== -1 && ((n = t.substr(o)), (t = t.substr(0, o))),
    { pathname: t, search: n === "?" ? "" : n, hash: r === "#" ? "" : r }
  );
}
function lt(e) {
  var t = e.pathname,
    n = e.search,
    r = e.hash,
    i = t || "/";
  return (
    n && n !== "?" && (i += n.charAt(0) === "?" ? n : "?" + n),
    r && r !== "#" && (i += r.charAt(0) === "#" ? r : "#" + r),
    i
  );
}
function et(e, t, n, r) {
  var i;
  typeof e == "string"
    ? ((i = Av(e)), (i.state = t))
    : ((i = nr({}, e)),
      i.pathname === void 0 && (i.pathname = ""),
      i.search
        ? i.search.charAt(0) !== "?" && (i.search = "?" + i.search)
        : (i.search = ""),
      i.hash
        ? i.hash.charAt(0) !== "#" && (i.hash = "#" + i.hash)
        : (i.hash = ""),
      t !== void 0 && i.state === void 0 && (i.state = t));
  try {
    i.pathname = decodeURI(i.pathname);
  } catch (o) {
    throw o instanceof URIError
      ? new URIError(
          'Pathname "' +
            i.pathname +
            '" could not be decoded. This is likely caused by an invalid percent-encoding.'
        )
      : o;
  }
  return (
    n && (i.key = n),
    r
      ? i.pathname
        ? i.pathname.charAt(0) !== "/" &&
          (i.pathname = Ov(i.pathname, r.pathname))
        : (i.pathname = r.pathname)
      : i.pathname || (i.pathname = "/"),
    i
  );
}
function Va() {
  var e = null;
  function t(l) {
    return (
      (e = l),
      function () {
        e === l && (e = null);
      }
    );
  }
  function n(l, a, s, u) {
    if (e != null) {
      var c = typeof e == "function" ? e(l, a) : e;
      typeof c == "string"
        ? typeof s == "function"
          ? s(c, u)
          : u(!0)
        : u(c !== !1);
    } else u(!0);
  }
  var r = [];
  function i(l) {
    var a = !0;
    function s() {
      a && l.apply(void 0, arguments);
    }
    return (
      r.push(s),
      function () {
        (a = !1),
          (r = r.filter(function (u) {
            return u !== s;
          }));
      }
    );
  }
  function o() {
    for (var l = arguments.length, a = new Array(l), s = 0; s < l; s++)
      a[s] = arguments[s];
    r.forEach(function (u) {
      return u.apply(void 0, a);
    });
  }
  return {
    setPrompt: t,
    confirmTransitionTo: n,
    appendListener: i,
    notifyListeners: o,
  };
}
var up = !!(
  typeof window != "undefined" &&
  window.document &&
  window.document.createElement
);
function cp(e, t) {
  t(window.confirm(e));
}
function zv() {
  var e = window.navigator.userAgent;
  return (e.indexOf("Android 2.") !== -1 || e.indexOf("Android 4.0") !== -1) &&
    e.indexOf("Mobile Safari") !== -1 &&
    e.indexOf("Chrome") === -1 &&
    e.indexOf("Windows Phone") === -1
    ? !1
    : window.history && "pushState" in window.history;
}
function Rv() {
  return window.navigator.userAgent.indexOf("Trident") === -1;
}
function Iv() {
  return window.navigator.userAgent.indexOf("Firefox") === -1;
}
function bv(e) {
  return e.state === void 0 && navigator.userAgent.indexOf("CriOS") === -1;
}
var gc = "popstate",
  yc = "hashchange";
function Sc() {
  try {
    return window.history.state || {};
  } catch {
    return {};
  }
}
function Dv(e) {
  e === void 0 && (e = {}), up || _n(!1);
  var t = window.history,
    n = zv(),
    r = !Rv(),
    i = e,
    o = i.forceRefresh,
    l = o === void 0 ? !1 : o,
    a = i.getUserConfirmation,
    s = a === void 0 ? cp : a,
    u = i.keyLength,
    c = u === void 0 ? 6 : u,
    f = e.basename ? ap(jr(e.basename)) : "";
  function d(O) {
    var M = O || {},
      F = M.key,
      _ = M.state,
      z = window.location,
      b = z.pathname,
      W = z.search,
      C = z.hash,
      Y = b + W + C;
    return f && (Y = sp(Y, f)), et(Y, _, F);
  }
  function v() {
    return Math.random().toString(36).substr(2, c);
  }
  var g = Va();
  function y(O) {
    nr($, O), ($.length = t.length), g.notifyListeners($.location, $.action);
  }
  function x(O) {
    bv(O) || m(d(O.state));
  }
  function h() {
    m(d(Sc()));
  }
  var p = !1;
  function m(O) {
    if (p) (p = !1), y();
    else {
      var M = "POP";
      g.confirmTransitionTo(O, M, s, function (F) {
        F ? y({ action: M, location: O }) : S(O);
      });
    }
  }
  function S(O) {
    var M = $.location,
      F = P.indexOf(M.key);
    F === -1 && (F = 0);
    var _ = P.indexOf(O.key);
    _ === -1 && (_ = 0);
    var z = F - _;
    z && ((p = !0), L(z));
  }
  var w = d(Sc()),
    P = [w.key];
  function E(O) {
    return f + lt(O);
  }
  function k(O, M) {
    var F = "PUSH",
      _ = et(O, M, v(), $.location);
    g.confirmTransitionTo(_, F, s, function (z) {
      if (!!z) {
        var b = E(_),
          W = _.key,
          C = _.state;
        if (n)
          if ((t.pushState({ key: W, state: C }, null, b), l))
            window.location.href = b;
          else {
            var Y = P.indexOf($.location.key),
              I = P.slice(0, Y + 1);
            I.push(_.key), (P = I), y({ action: F, location: _ });
          }
        else window.location.href = b;
      }
    });
  }
  function D(O, M) {
    var F = "REPLACE",
      _ = et(O, M, v(), $.location);
    g.confirmTransitionTo(_, F, s, function (z) {
      if (!!z) {
        var b = E(_),
          W = _.key,
          C = _.state;
        if (n)
          if ((t.replaceState({ key: W, state: C }, null, b), l))
            window.location.replace(b);
          else {
            var Y = P.indexOf($.location.key);
            Y !== -1 && (P[Y] = _.key), y({ action: F, location: _ });
          }
        else window.location.replace(b);
      }
    });
  }
  function L(O) {
    t.go(O);
  }
  function T() {
    L(-1);
  }
  function N() {
    L(1);
  }
  var j = 0;
  function U(O) {
    (j += O),
      j === 1 && O === 1
        ? (window.addEventListener(gc, x), r && window.addEventListener(yc, h))
        : j === 0 &&
          (window.removeEventListener(gc, x),
          r && window.removeEventListener(yc, h));
  }
  var B = !1;
  function Z(O) {
    O === void 0 && (O = !1);
    var M = g.setPrompt(O);
    return (
      B || (U(1), (B = !0)),
      function () {
        return B && ((B = !1), U(-1)), M();
      }
    );
  }
  function q(O) {
    var M = g.appendListener(O);
    return (
      U(1),
      function () {
        U(-1), M();
      }
    );
  }
  var $ = {
    length: t.length,
    action: "POP",
    location: w,
    createHref: E,
    push: k,
    replace: D,
    go: L,
    goBack: T,
    goForward: N,
    block: Z,
    listen: q,
  };
  return $;
}
var wc = "hashchange",
  jv = {
    hashbang: {
      encodePath: function (t) {
        return t.charAt(0) === "!" ? t : "!/" + vc(t);
      },
      decodePath: function (t) {
        return t.charAt(0) === "!" ? t.substr(1) : t;
      },
    },
    noslash: { encodePath: vc, decodePath: jr },
    slash: { encodePath: jr, decodePath: jr },
  };
function fp(e) {
  var t = e.indexOf("#");
  return t === -1 ? e : e.slice(0, t);
}
function kr() {
  var e = window.location.href,
    t = e.indexOf("#");
  return t === -1 ? "" : e.substring(t + 1);
}
function Fv(e) {
  window.location.hash = e;
}
function zl(e) {
  window.location.replace(fp(window.location.href) + "#" + e);
}
function Bv(e) {
  e === void 0 && (e = {}), up || _n(!1);
  var t = window.history;
  Iv();
  var n = e,
    r = n.getUserConfirmation,
    i = r === void 0 ? cp : r,
    o = n.hashType,
    l = o === void 0 ? "slash" : o,
    a = e.basename ? ap(jr(e.basename)) : "",
    s = jv[l],
    u = s.encodePath,
    c = s.decodePath;
  function f() {
    var M = c(kr());
    return a && (M = sp(M, a)), et(M);
  }
  var d = Va();
  function v(M) {
    nr(O, M), (O.length = t.length), d.notifyListeners(O.location, O.action);
  }
  var g = !1,
    y = null;
  function x(M, F) {
    return (
      M.pathname === F.pathname && M.search === F.search && M.hash === F.hash
    );
  }
  function h() {
    var M = kr(),
      F = u(M);
    if (M !== F) zl(F);
    else {
      var _ = f(),
        z = O.location;
      if ((!g && x(z, _)) || y === lt(_)) return;
      (y = null), p(_);
    }
  }
  function p(M) {
    if (g) (g = !1), v();
    else {
      var F = "POP";
      d.confirmTransitionTo(M, F, i, function (_) {
        _ ? v({ action: F, location: M }) : m(M);
      });
    }
  }
  function m(M) {
    var F = O.location,
      _ = E.lastIndexOf(lt(F));
    _ === -1 && (_ = 0);
    var z = E.lastIndexOf(lt(M));
    z === -1 && (z = 0);
    var b = _ - z;
    b && ((g = !0), T(b));
  }
  var S = kr(),
    w = u(S);
  S !== w && zl(w);
  var P = f(),
    E = [lt(P)];
  function k(M) {
    var F = document.querySelector("base"),
      _ = "";
    return (
      F && F.getAttribute("href") && (_ = fp(window.location.href)),
      _ + "#" + u(a + lt(M))
    );
  }
  function D(M, F) {
    var _ = "PUSH",
      z = et(M, void 0, void 0, O.location);
    d.confirmTransitionTo(z, _, i, function (b) {
      if (!!b) {
        var W = lt(z),
          C = u(a + W),
          Y = kr() !== C;
        if (Y) {
          (y = W), Fv(C);
          var I = E.lastIndexOf(lt(O.location)),
            ae = E.slice(0, I + 1);
          ae.push(W), (E = ae), v({ action: _, location: z });
        } else v();
      }
    });
  }
  function L(M, F) {
    var _ = "REPLACE",
      z = et(M, void 0, void 0, O.location);
    d.confirmTransitionTo(z, _, i, function (b) {
      if (!!b) {
        var W = lt(z),
          C = u(a + W),
          Y = kr() !== C;
        Y && ((y = W), zl(C));
        var I = E.indexOf(lt(O.location));
        I !== -1 && (E[I] = W), v({ action: _, location: z });
      }
    });
  }
  function T(M) {
    t.go(M);
  }
  function N() {
    T(-1);
  }
  function j() {
    T(1);
  }
  var U = 0;
  function B(M) {
    (U += M),
      U === 1 && M === 1
        ? window.addEventListener(wc, h)
        : U === 0 && window.removeEventListener(wc, h);
  }
  var Z = !1;
  function q(M) {
    M === void 0 && (M = !1);
    var F = d.setPrompt(M);
    return (
      Z || (B(1), (Z = !0)),
      function () {
        return Z && ((Z = !1), B(-1)), F();
      }
    );
  }
  function $(M) {
    var F = d.appendListener(M);
    return (
      B(1),
      function () {
        B(-1), F();
      }
    );
  }
  var O = {
    length: t.length,
    action: "POP",
    location: P,
    createHref: k,
    push: D,
    replace: L,
    go: T,
    goBack: N,
    goForward: j,
    block: q,
    listen: $,
  };
  return O;
}
function xc(e, t, n) {
  return Math.min(Math.max(e, t), n);
}
function Vv(e) {
  e === void 0 && (e = {});
  var t = e,
    n = t.getUserConfirmation,
    r = t.initialEntries,
    i = r === void 0 ? ["/"] : r,
    o = t.initialIndex,
    l = o === void 0 ? 0 : o,
    a = t.keyLength,
    s = a === void 0 ? 6 : a,
    u = Va();
  function c(k) {
    nr(E, k),
      (E.length = E.entries.length),
      u.notifyListeners(E.location, E.action);
  }
  function f() {
    return Math.random().toString(36).substr(2, s);
  }
  var d = xc(l, 0, i.length - 1),
    v = i.map(function (k) {
      return typeof k == "string"
        ? et(k, void 0, f())
        : et(k, void 0, k.key || f());
    }),
    g = lt;
  function y(k, D) {
    var L = "PUSH",
      T = et(k, D, f(), E.location);
    u.confirmTransitionTo(T, L, n, function (N) {
      if (!!N) {
        var j = E.index,
          U = j + 1,
          B = E.entries.slice(0);
        B.length > U ? B.splice(U, B.length - U, T) : B.push(T),
          c({ action: L, location: T, index: U, entries: B });
      }
    });
  }
  function x(k, D) {
    var L = "REPLACE",
      T = et(k, D, f(), E.location);
    u.confirmTransitionTo(T, L, n, function (N) {
      !N || ((E.entries[E.index] = T), c({ action: L, location: T }));
    });
  }
  function h(k) {
    var D = xc(E.index + k, 0, E.entries.length - 1),
      L = "POP",
      T = E.entries[D];
    u.confirmTransitionTo(T, L, n, function (N) {
      N ? c({ action: L, location: T, index: D }) : c();
    });
  }
  function p() {
    h(-1);
  }
  function m() {
    h(1);
  }
  function S(k) {
    var D = E.index + k;
    return D >= 0 && D < E.entries.length;
  }
  function w(k) {
    return k === void 0 && (k = !1), u.setPrompt(k);
  }
  function P(k) {
    return u.appendListener(k);
  }
  var E = {
    length: v.length,
    action: "POP",
    location: v[d],
    index: d,
    entries: v,
    createHref: g,
    push: y,
    replace: x,
    go: h,
    goBack: p,
    goForward: m,
    canGo: S,
    block: w,
    listen: P,
  };
  return E;
}
function Ds(e, t) {
  return (
    (Ds = Object.setPrototypeOf
      ? Object.setPrototypeOf.bind()
      : function (r, i) {
          return (r.__proto__ = i), r;
        }),
    Ds(e, t)
  );
}
function Cc(e, t) {
  (e.prototype = Object.create(t.prototype)),
    (e.prototype.constructor = e),
    Ds(e, t);
}
var Rl = 1073741823,
  Ec =
    typeof globalThis != "undefined"
      ? globalThis
      : typeof window != "undefined"
      ? window
      : typeof global != "undefined"
      ? global
      : {};
function Hv() {
  var e = "__global_unique_id__";
  return (Ec[e] = (Ec[e] || 0) + 1);
}
function Uv(e, t) {
  return e === t ? e !== 0 || 1 / e === 1 / t : e !== e && t !== t;
}
function Wv(e) {
  var t = [];
  return {
    on: function (r) {
      t.push(r);
    },
    off: function (r) {
      t = t.filter(function (i) {
        return i !== r;
      });
    },
    get: function () {
      return e;
    },
    set: function (r, i) {
      (e = r),
        t.forEach(function (o) {
          return o(e, i);
        });
    },
  };
}
function Gv(e) {
  return Array.isArray(e) ? e[0] : e;
}
function Yv(e, t) {
  var n,
    r,
    i = "__create-react-context-" + Hv() + "__",
    o = (function (a) {
      Cc(s, a);
      function s() {
        var c;
        return (
          (c = a.apply(this, arguments) || this),
          (c.emitter = Wv(c.props.value)),
          c
        );
      }
      var u = s.prototype;
      return (
        (u.getChildContext = function () {
          var f;
          return (f = {}), (f[i] = this.emitter), f;
        }),
        (u.componentWillReceiveProps = function (f) {
          if (this.props.value !== f.value) {
            var d = this.props.value,
              v = f.value,
              g;
            Uv(d, v)
              ? (g = 0)
              : ((g = typeof t == "function" ? t(d, v) : Rl),
                (g |= 0),
                g !== 0 && this.emitter.set(f.value, g));
          }
        }),
        (u.render = function () {
          return this.props.children;
        }),
        s
      );
    })(A.exports.Component);
  o.childContextTypes = ((n = {}), (n[i] = mc.object.isRequired), n);
  var l = (function (a) {
    Cc(s, a);
    function s() {
      var c;
      return (
        (c = a.apply(this, arguments) || this),
        (c.state = { value: c.getValue() }),
        (c.onUpdate = function (f, d) {
          var v = c.observedBits | 0;
          (v & d) !== 0 && c.setState({ value: c.getValue() });
        }),
        c
      );
    }
    var u = s.prototype;
    return (
      (u.componentWillReceiveProps = function (f) {
        var d = f.observedBits;
        this.observedBits = d == null ? Rl : d;
      }),
      (u.componentDidMount = function () {
        this.context[i] && this.context[i].on(this.onUpdate);
        var f = this.props.observedBits;
        this.observedBits = f == null ? Rl : f;
      }),
      (u.componentWillUnmount = function () {
        this.context[i] && this.context[i].off(this.onUpdate);
      }),
      (u.getValue = function () {
        return this.context[i] ? this.context[i].get() : e;
      }),
      (u.render = function () {
        return Gv(this.props.children)(this.state.value);
      }),
      s
    );
  })(A.exports.Component);
  return (
    (l.contextTypes = ((r = {}), (r[i] = mc.object), r)),
    { Provider: o, Consumer: l }
  );
}
var dp = Q.createContext || Yv;
function xn() {
  return (
    (xn = Object.assign
      ? Object.assign.bind()
      : function (e) {
          for (var t = 1; t < arguments.length; t++) {
            var n = arguments[t];
            for (var r in n)
              Object.prototype.hasOwnProperty.call(n, r) && (e[r] = n[r]);
          }
          return e;
        }),
    xn.apply(this, arguments)
  );
}
var pr = { exports: {} },
  Xv =
    Array.isArray ||
    function (e) {
      return Object.prototype.toString.call(e) == "[object Array]";
    },
  Co = Xv;
pr.exports = mp;
pr.exports.parse = Ha;
pr.exports.compile = Kv;
pr.exports.tokensToFunction = pp;
pr.exports.tokensToRegExp = hp;
var Qv = new RegExp(
  [
    "(\\\\.)",
    "([\\/.])?(?:(?:\\:(\\w+)(?:\\(((?:\\\\.|[^\\\\()])+)\\))?|\\(((?:\\\\.|[^\\\\()])+)\\))([+*?])?|(\\*))",
  ].join("|"),
  "g"
);
function Ha(e, t) {
  for (
    var n = [], r = 0, i = 0, o = "", l = (t && t.delimiter) || "/", a;
    (a = Qv.exec(e)) != null;

  ) {
    var s = a[0],
      u = a[1],
      c = a.index;
    if (((o += e.slice(i, c)), (i = c + s.length), u)) {
      o += u[1];
      continue;
    }
    var f = e[i],
      d = a[2],
      v = a[3],
      g = a[4],
      y = a[5],
      x = a[6],
      h = a[7];
    o && (n.push(o), (o = ""));
    var p = d != null && f != null && f !== d,
      m = x === "+" || x === "*",
      S = x === "?" || x === "*",
      w = a[2] || l,
      P = g || y;
    n.push({
      name: v || r++,
      prefix: d || "",
      delimiter: w,
      optional: S,
      repeat: m,
      partial: p,
      asterisk: !!h,
      pattern: P ? Jv(P) : h ? ".*" : "[^" + Qi(w) + "]+?",
    });
  }
  return i < e.length && (o += e.substr(i)), o && n.push(o), n;
}
function Kv(e, t) {
  return pp(Ha(e, t), t);
}
function Zv(e) {
  return encodeURI(e).replace(/[\/?#]/g, function (t) {
    return "%" + t.charCodeAt(0).toString(16).toUpperCase();
  });
}
function qv(e) {
  return encodeURI(e).replace(/[?#]/g, function (t) {
    return "%" + t.charCodeAt(0).toString(16).toUpperCase();
  });
}
function pp(e, t) {
  for (var n = new Array(e.length), r = 0; r < e.length; r++)
    typeof e[r] == "object" &&
      (n[r] = new RegExp("^(?:" + e[r].pattern + ")$", Wa(t)));
  return function (i, o) {
    for (
      var l = "",
        a = i || {},
        s = o || {},
        u = s.pretty ? Zv : encodeURIComponent,
        c = 0;
      c < e.length;
      c++
    ) {
      var f = e[c];
      if (typeof f == "string") {
        l += f;
        continue;
      }
      var d = a[f.name],
        v;
      if (d == null)
        if (f.optional) {
          f.partial && (l += f.prefix);
          continue;
        } else throw new TypeError('Expected "' + f.name + '" to be defined');
      if (Co(d)) {
        if (!f.repeat)
          throw new TypeError(
            'Expected "' +
              f.name +
              '" to not repeat, but received `' +
              JSON.stringify(d) +
              "`"
          );
        if (d.length === 0) {
          if (f.optional) continue;
          throw new TypeError('Expected "' + f.name + '" to not be empty');
        }
        for (var g = 0; g < d.length; g++) {
          if (((v = u(d[g])), !n[c].test(v)))
            throw new TypeError(
              'Expected all "' +
                f.name +
                '" to match "' +
                f.pattern +
                '", but received `' +
                JSON.stringify(v) +
                "`"
            );
          l += (g === 0 ? f.prefix : f.delimiter) + v;
        }
        continue;
      }
      if (((v = f.asterisk ? qv(d) : u(d)), !n[c].test(v)))
        throw new TypeError(
          'Expected "' +
            f.name +
            '" to match "' +
            f.pattern +
            '", but received "' +
            v +
            '"'
        );
      l += f.prefix + v;
    }
    return l;
  };
}
function Qi(e) {
  return e.replace(/([.+*?=^!:${}()[\]|\/\\])/g, "\\$1");
}
function Jv(e) {
  return e.replace(/([=!:$\/()])/g, "\\$1");
}
function Ua(e, t) {
  return (e.keys = t), e;
}
function Wa(e) {
  return e && e.sensitive ? "" : "i";
}
function eg(e, t) {
  var n = e.source.match(/\((?!\?)/g);
  if (n)
    for (var r = 0; r < n.length; r++)
      t.push({
        name: r,
        prefix: null,
        delimiter: null,
        optional: !1,
        repeat: !1,
        partial: !1,
        asterisk: !1,
        pattern: null,
      });
  return Ua(e, t);
}
function tg(e, t, n) {
  for (var r = [], i = 0; i < e.length; i++) r.push(mp(e[i], t, n).source);
  var o = new RegExp("(?:" + r.join("|") + ")", Wa(n));
  return Ua(o, t);
}
function ng(e, t, n) {
  return hp(Ha(e, n), t, n);
}
function hp(e, t, n) {
  Co(t) || ((n = t || n), (t = [])), (n = n || {});
  for (var r = n.strict, i = n.end !== !1, o = "", l = 0; l < e.length; l++) {
    var a = e[l];
    if (typeof a == "string") o += Qi(a);
    else {
      var s = Qi(a.prefix),
        u = "(?:" + a.pattern + ")";
      t.push(a),
        a.repeat && (u += "(?:" + s + u + ")*"),
        a.optional
          ? a.partial
            ? (u = s + "(" + u + ")?")
            : (u = "(?:" + s + "(" + u + "))?")
          : (u = s + "(" + u + ")"),
        (o += u);
    }
  }
  var c = Qi(n.delimiter || "/"),
    f = o.slice(-c.length) === c;
  return (
    r || (o = (f ? o.slice(0, -c.length) : o) + "(?:" + c + "(?=$))?"),
    i ? (o += "$") : (o += r && f ? "" : "(?=" + c + "|$)"),
    Ua(new RegExp("^" + o, Wa(n)), t)
  );
}
function mp(e, t, n) {
  return (
    Co(t) || ((n = t || n), (t = [])),
    (n = n || {}),
    e instanceof RegExp ? eg(e, t) : Co(e) ? tg(e, t, n) : ng(e, t, n)
  );
}
var rg = pr.exports,
  Ho = { exports: {} },
  le = {};
/** @license React v16.13.1
 * react-is.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */ var Pe = typeof Symbol == "function" && Symbol.for,
  Ga = Pe ? Symbol.for("react.element") : 60103,
  Ya = Pe ? Symbol.for("react.portal") : 60106,
  Uo = Pe ? Symbol.for("react.fragment") : 60107,
  Wo = Pe ? Symbol.for("react.strict_mode") : 60108,
  Go = Pe ? Symbol.for("react.profiler") : 60114,
  Yo = Pe ? Symbol.for("react.provider") : 60109,
  Xo = Pe ? Symbol.for("react.context") : 60110,
  Xa = Pe ? Symbol.for("react.async_mode") : 60111,
  Qo = Pe ? Symbol.for("react.concurrent_mode") : 60111,
  Ko = Pe ? Symbol.for("react.forward_ref") : 60112,
  Zo = Pe ? Symbol.for("react.suspense") : 60113,
  ig = Pe ? Symbol.for("react.suspense_list") : 60120,
  qo = Pe ? Symbol.for("react.memo") : 60115,
  Jo = Pe ? Symbol.for("react.lazy") : 60116,
  og = Pe ? Symbol.for("react.block") : 60121,
  lg = Pe ? Symbol.for("react.fundamental") : 60117,
  sg = Pe ? Symbol.for("react.responder") : 60118,
  ag = Pe ? Symbol.for("react.scope") : 60119;
function ot(e) {
  if (typeof e == "object" && e !== null) {
    var t = e.$$typeof;
    switch (t) {
      case Ga:
        switch (((e = e.type), e)) {
          case Xa:
          case Qo:
          case Uo:
          case Go:
          case Wo:
          case Zo:
            return e;
          default:
            switch (((e = e && e.$$typeof), e)) {
              case Xo:
              case Ko:
              case Jo:
              case qo:
              case Yo:
                return e;
              default:
                return t;
            }
        }
      case Ya:
        return t;
    }
  }
}
function vp(e) {
  return ot(e) === Qo;
}
le.AsyncMode = Xa;
le.ConcurrentMode = Qo;
le.ContextConsumer = Xo;
le.ContextProvider = Yo;
le.Element = Ga;
le.ForwardRef = Ko;
le.Fragment = Uo;
le.Lazy = Jo;
le.Memo = qo;
le.Portal = Ya;
le.Profiler = Go;
le.StrictMode = Wo;
le.Suspense = Zo;
le.isAsyncMode = function (e) {
  return vp(e) || ot(e) === Xa;
};
le.isConcurrentMode = vp;
le.isContextConsumer = function (e) {
  return ot(e) === Xo;
};
le.isContextProvider = function (e) {
  return ot(e) === Yo;
};
le.isElement = function (e) {
  return typeof e == "object" && e !== null && e.$$typeof === Ga;
};
le.isForwardRef = function (e) {
  return ot(e) === Ko;
};
le.isFragment = function (e) {
  return ot(e) === Uo;
};
le.isLazy = function (e) {
  return ot(e) === Jo;
};
le.isMemo = function (e) {
  return ot(e) === qo;
};
le.isPortal = function (e) {
  return ot(e) === Ya;
};
le.isProfiler = function (e) {
  return ot(e) === Go;
};
le.isStrictMode = function (e) {
  return ot(e) === Wo;
};
le.isSuspense = function (e) {
  return ot(e) === Zo;
};
le.isValidElementType = function (e) {
  return (
    typeof e == "string" ||
    typeof e == "function" ||
    e === Uo ||
    e === Qo ||
    e === Go ||
    e === Wo ||
    e === Zo ||
    e === ig ||
    (typeof e == "object" &&
      e !== null &&
      (e.$$typeof === Jo ||
        e.$$typeof === qo ||
        e.$$typeof === Yo ||
        e.$$typeof === Xo ||
        e.$$typeof === Ko ||
        e.$$typeof === lg ||
        e.$$typeof === sg ||
        e.$$typeof === ag ||
        e.$$typeof === og))
  );
};
le.typeOf = ot;
Ho.exports = le;
function ug(e, t) {
  if (e == null) return {};
  var n = {},
    r = Object.keys(e),
    i,
    o;
  for (o = 0; o < r.length; o++)
    (i = r[o]), !(t.indexOf(i) >= 0) && (n[i] = e[i]);
  return n;
}
var Qa = Ho.exports,
  cg = {
    childContextTypes: !0,
    contextType: !0,
    contextTypes: !0,
    defaultProps: !0,
    displayName: !0,
    getDefaultProps: !0,
    getDerivedStateFromError: !0,
    getDerivedStateFromProps: !0,
    mixins: !0,
    propTypes: !0,
    type: !0,
  },
  fg = {
    name: !0,
    length: !0,
    prototype: !0,
    caller: !0,
    callee: !0,
    arguments: !0,
    arity: !0,
  },
  dg = {
    $$typeof: !0,
    render: !0,
    defaultProps: !0,
    displayName: !0,
    propTypes: !0,
  },
  gp = {
    $$typeof: !0,
    compare: !0,
    defaultProps: !0,
    displayName: !0,
    propTypes: !0,
    type: !0,
  },
  Ka = {};
Ka[Qa.ForwardRef] = dg;
Ka[Qa.Memo] = gp;
function Tc(e) {
  return Qa.isMemo(e) ? gp : Ka[e.$$typeof] || cg;
}
var pg = Object.defineProperty,
  hg = Object.getOwnPropertyNames,
  kc = Object.getOwnPropertySymbols,
  mg = Object.getOwnPropertyDescriptor,
  vg = Object.getPrototypeOf,
  Pc = Object.prototype;
function yp(e, t, n) {
  if (typeof t != "string") {
    if (Pc) {
      var r = vg(t);
      r && r !== Pc && yp(e, r, n);
    }
    var i = hg(t);
    kc && (i = i.concat(kc(t)));
    for (var o = Tc(e), l = Tc(t), a = 0; a < i.length; ++a) {
      var s = i[a];
      if (!fg[s] && !(n && n[s]) && !(l && l[s]) && !(o && o[s])) {
        var u = mg(t, s);
        try {
          pg(e, s, u);
        } catch {}
      }
    }
  }
  return e;
}
var gg = yp,
  yg = function (t) {
    var n = dp();
    return (n.displayName = t), n;
  },
  Sp = yg("Router-History"),
  Sg = function (t) {
    var n = dp();
    return (n.displayName = t), n;
  },
  rr = Sg("Router"),
  el = (function (e) {
    dr(t, e),
      (t.computeRootMatch = function (i) {
        return { path: "/", url: "/", params: {}, isExact: i === "/" };
      });
    function t(r) {
      var i;
      return (
        (i = e.call(this, r) || this),
        (i.state = { location: r.history.location }),
        (i._isMounted = !1),
        (i._pendingLocation = null),
        r.staticContext ||
          (i.unlisten = r.history.listen(function (o) {
            i._isMounted
              ? i.setState({ location: o })
              : (i._pendingLocation = o);
          })),
        i
      );
    }
    var n = t.prototype;
    return (
      (n.componentDidMount = function () {
        (this._isMounted = !0),
          this._pendingLocation &&
            this.setState({ location: this._pendingLocation });
      }),
      (n.componentWillUnmount = function () {
        this.unlisten && this.unlisten();
      }),
      (n.render = function () {
        return Q.createElement(
          rr.Provider,
          {
            value: {
              history: this.props.history,
              location: this.state.location,
              match: t.computeRootMatch(this.state.location.pathname),
              staticContext: this.props.staticContext,
            },
          },
          Q.createElement(Sp.Provider, {
            children: this.props.children || null,
            value: this.props.history,
          })
        );
      }),
      t
    );
  })(Q.Component);
Q.Component;
Q.Component;
var $c = {},
  wg = 1e4,
  _c = 0;
function xg(e, t) {
  var n = "" + t.end + t.strict + t.sensitive,
    r = $c[n] || ($c[n] = {});
  if (r[e]) return r[e];
  var i = [],
    o = rg(e, i, t),
    l = { regexp: o, keys: i };
  return _c < wg && ((r[e] = l), _c++), l;
}
function Za(e, t) {
  t === void 0 && (t = {}),
    (typeof t == "string" || Array.isArray(t)) && (t = { path: t });
  var n = t,
    r = n.path,
    i = n.exact,
    o = i === void 0 ? !1 : i,
    l = n.strict,
    a = l === void 0 ? !1 : l,
    s = n.sensitive,
    u = s === void 0 ? !1 : s,
    c = [].concat(r);
  return c.reduce(function (f, d) {
    if (!d && d !== "") return null;
    if (f) return f;
    var v = xg(d, { end: o, strict: a, sensitive: u }),
      g = v.regexp,
      y = v.keys,
      x = g.exec(e);
    if (!x) return null;
    var h = x[0],
      p = x.slice(1),
      m = e === h;
    return o && !m
      ? null
      : {
          path: d,
          url: d === "/" && h === "" ? "/" : h,
          isExact: m,
          params: y.reduce(function (S, w, P) {
            return (S[w.name] = p[P]), S;
          }, {}),
        };
  }, null);
}
var Cg = (function (e) {
  dr(t, e);
  function t() {
    return e.apply(this, arguments) || this;
  }
  var n = t.prototype;
  return (
    (n.render = function () {
      var i = this;
      return Q.createElement(rr.Consumer, null, function (o) {
        o || _n(!1);
        var l = i.props.location || o.location,
          a = i.props.computedMatch
            ? i.props.computedMatch
            : i.props.path
            ? Za(l.pathname, i.props)
            : o.match,
          s = xn({}, o, { location: l, match: a }),
          u = i.props,
          c = u.children,
          f = u.component,
          d = u.render;
        return (
          Array.isArray(c) && c.length === 0 && (c = null),
          Q.createElement(
            rr.Provider,
            { value: s },
            s.match
              ? c
                ? typeof c == "function"
                  ? c(s)
                  : c
                : f
                ? Q.createElement(f, s)
                : d
                ? d(s)
                : null
              : typeof c == "function"
              ? c(s)
              : null
          )
        );
      });
    }),
    t
  );
})(Q.Component);
function qa(e) {
  return e.charAt(0) === "/" ? e : "/" + e;
}
function Eg(e, t) {
  return e ? xn({}, t, { pathname: qa(e) + t.pathname }) : t;
}
function Tg(e, t) {
  if (!e) return t;
  var n = qa(e);
  return t.pathname.indexOf(n) !== 0
    ? t
    : xn({}, t, { pathname: t.pathname.substr(n.length) });
}
function Lc(e) {
  return typeof e == "string" ? e : lt(e);
}
function Il(e) {
  return function () {
    _n(!1);
  };
}
function Oc() {}
Q.Component;
var kg = (function (e) {
    dr(t, e);
    function t() {
      return e.apply(this, arguments) || this;
    }
    var n = t.prototype;
    return (
      (n.render = function () {
        var i = this;
        return Q.createElement(rr.Consumer, null, function (o) {
          o || _n(!1);
          var l = i.props.location || o.location,
            a,
            s;
          return (
            Q.Children.forEach(i.props.children, function (u) {
              if (s == null && Q.isValidElement(u)) {
                a = u;
                var c = u.props.path || u.props.from;
                s = c ? Za(l.pathname, xn({}, u.props, { path: c })) : o.match;
              }
            }),
            s ? Q.cloneElement(a, { location: l, computedMatch: s }) : null
          );
        });
      }),
      t
    );
  })(Q.Component),
  Pg = Q.useContext;
function $g() {
  return Pg(Sp);
}
function js(e, t) {
  return (
    (js = Object.setPrototypeOf
      ? Object.setPrototypeOf.bind()
      : function (r, i) {
          return (r.__proto__ = i), r;
        }),
    js(e, t)
  );
}
function wp(e, t) {
  (e.prototype = Object.create(t.prototype)),
    (e.prototype.constructor = e),
    js(e, t);
}
function ir() {
  return (
    (ir = Object.assign
      ? Object.assign.bind()
      : function (e) {
          for (var t = 1; t < arguments.length; t++) {
            var n = arguments[t];
            for (var r in n)
              Object.prototype.hasOwnProperty.call(n, r) && (e[r] = n[r]);
          }
          return e;
        }),
    ir.apply(this, arguments)
  );
}
function Ja(e, t) {
  if (e == null) return {};
  var n = {},
    r = Object.keys(e),
    i,
    o;
  for (o = 0; o < r.length; o++)
    (i = r[o]), !(t.indexOf(i) >= 0) && (n[i] = e[i]);
  return n;
}
Q.Component;
var _g = (function (e) {
    wp(t, e);
    function t() {
      for (var r, i = arguments.length, o = new Array(i), l = 0; l < i; l++)
        o[l] = arguments[l];
      return (
        (r = e.call.apply(e, [this].concat(o)) || this),
        (r.history = Bv(r.props)),
        r
      );
    }
    var n = t.prototype;
    return (
      (n.render = function () {
        return Q.createElement(el, {
          history: this.history,
          children: this.props.children,
        });
      }),
      t
    );
  })(Q.Component),
  Fs = function (t, n) {
    return typeof t == "function" ? t(n) : t;
  },
  xp = function (t, n) {
    return typeof t == "string" ? et(t, null, null, n) : t;
  },
  eu = function (t) {
    return t;
  },
  or = Q.forwardRef;
typeof or == "undefined" && (or = eu);
function Lg(e) {
  return !!(e.metaKey || e.altKey || e.ctrlKey || e.shiftKey);
}
var Og = or(function (e, t) {
    var n = e.innerRef,
      r = e.navigate,
      i = e.onClick,
      o = Ja(e, ["innerRef", "navigate", "onClick"]),
      l = o.target,
      a = ir({}, o, {
        onClick: function (u) {
          try {
            i && i(u);
          } catch (c) {
            throw (u.preventDefault(), c);
          }
          !u.defaultPrevented &&
            u.button === 0 &&
            (!l || l === "_self") &&
            !Lg(u) &&
            (u.preventDefault(), r());
        },
      });
    return eu !== or ? (a.ref = t || n) : (a.ref = n), Q.createElement("a", a);
  }),
  Mg = or(function (e, t) {
    var n = e.component,
      r = n === void 0 ? Og : n,
      i = e.replace,
      o = e.to,
      l = e.innerRef,
      a = Ja(e, ["component", "replace", "to", "innerRef"]);
    return Q.createElement(rr.Consumer, null, function (s) {
      s || _n(!1);
      var u = s.history,
        c = xp(Fs(o, s.location), s.location),
        f = c ? u.createHref(c) : "",
        d = ir({}, a, {
          href: f,
          navigate: function () {
            var g = Fs(o, s.location),
              y = i ? u.replace : u.push;
            y(g);
          },
        });
      return (
        eu !== or ? (d.ref = t || l) : (d.innerRef = l), Q.createElement(r, d)
      );
    });
  }),
  Cp = function (t) {
    return t;
  },
  Eo = Q.forwardRef;
typeof Eo == "undefined" && (Eo = Cp);
function Ng() {
  for (var e = arguments.length, t = new Array(e), n = 0; n < e; n++)
    t[n] = arguments[n];
  return t
    .filter(function (r) {
      return r;
    })
    .join(" ");
}
Eo(function (e, t) {
  var n = e["aria-current"],
    r = n === void 0 ? "page" : n,
    i = e.activeClassName,
    o = i === void 0 ? "active" : i,
    l = e.activeStyle,
    a = e.className,
    s = e.exact,
    u = e.isActive,
    c = e.location,
    f = e.sensitive,
    d = e.strict,
    v = e.style,
    g = e.to,
    y = e.innerRef,
    x = Ja(e, [
      "aria-current",
      "activeClassName",
      "activeStyle",
      "className",
      "exact",
      "isActive",
      "location",
      "sensitive",
      "strict",
      "style",
      "to",
      "innerRef",
    ]);
  return Q.createElement(rr.Consumer, null, function (h) {
    h || _n(!1);
    var p = c || h.location,
      m = xp(Fs(g, p), p),
      S = m.pathname,
      w = S && S.replace(/([.+*?=^!:${}()[\]|/\\])/g, "\\$1"),
      P = w
        ? Za(p.pathname, { path: w, exact: s, sensitive: f, strict: d })
        : null,
      E = !!(u ? u(P, p) : P),
      k = E ? Ng(a, o) : a,
      D = E ? ir({}, v, {}, l) : v,
      L = ir(
        { "aria-current": (E && r) || null, className: k, style: D, to: m },
        x
      );
    return (
      Cp !== Eo ? (L.ref = t || y) : (L.innerRef = y), Q.createElement(Mg, L)
    );
  });
});
function Ag(e) {
  function t(_, z, b, W, C) {
    for (
      var Y = 0,
        I = 0,
        ae = 0,
        ne = 0,
        ie,
        K,
        $e = 0,
        Ue = 0,
        te,
        Ae = (te = ie = 0),
        re = 0,
        _e = 0,
        mr = 0,
        Le = 0,
        pi = b.length,
        vr = pi - 1,
        pt,
        X = "",
        ge = "",
        il = "",
        ol = "",
        bt;
      re < pi;

    ) {
      if (
        ((K = b.charCodeAt(re)),
        re === vr &&
          I + ne + ae + Y !== 0 &&
          (I !== 0 && (K = I === 47 ? 10 : 47), (ne = ae = Y = 0), pi++, vr++),
        I + ne + ae + Y === 0)
      ) {
        if (
          re === vr &&
          (0 < _e && (X = X.replace(d, "")), 0 < X.trim().length)
        ) {
          switch (K) {
            case 32:
            case 9:
            case 59:
            case 13:
            case 10:
              break;
            default:
              X += b.charAt(re);
          }
          K = 59;
        }
        switch (K) {
          case 123:
            for (
              X = X.trim(), ie = X.charCodeAt(0), te = 1, Le = ++re;
              re < pi;

            ) {
              switch ((K = b.charCodeAt(re))) {
                case 123:
                  te++;
                  break;
                case 125:
                  te--;
                  break;
                case 47:
                  switch ((K = b.charCodeAt(re + 1))) {
                    case 42:
                    case 47:
                      e: {
                        for (Ae = re + 1; Ae < vr; ++Ae)
                          switch (b.charCodeAt(Ae)) {
                            case 47:
                              if (
                                K === 42 &&
                                b.charCodeAt(Ae - 1) === 42 &&
                                re + 2 !== Ae
                              ) {
                                re = Ae + 1;
                                break e;
                              }
                              break;
                            case 10:
                              if (K === 47) {
                                re = Ae + 1;
                                break e;
                              }
                          }
                        re = Ae;
                      }
                  }
                  break;
                case 91:
                  K++;
                case 40:
                  K++;
                case 34:
                case 39:
                  for (; re++ < vr && b.charCodeAt(re) !== K; );
              }
              if (te === 0) break;
              re++;
            }
            switch (
              ((te = b.substring(Le, re)),
              ie === 0 && (ie = (X = X.replace(f, "").trim()).charCodeAt(0)),
              ie)
            ) {
              case 64:
                switch (
                  (0 < _e && (X = X.replace(d, "")), (K = X.charCodeAt(1)), K)
                ) {
                  case 100:
                  case 109:
                  case 115:
                  case 45:
                    _e = z;
                    break;
                  default:
                    _e = Z;
                }
                if (
                  ((te = t(z, _e, te, K, C + 1)),
                  (Le = te.length),
                  0 < $ &&
                    ((_e = n(Z, X, mr)),
                    (bt = a(3, te, _e, z, j, N, Le, K, C, W)),
                    (X = _e.join("")),
                    bt !== void 0 &&
                      (Le = (te = bt.trim()).length) === 0 &&
                      ((K = 0), (te = ""))),
                  0 < Le)
                )
                  switch (K) {
                    case 115:
                      X = X.replace(P, l);
                    case 100:
                    case 109:
                    case 45:
                      te = X + "{" + te + "}";
                      break;
                    case 107:
                      (X = X.replace(p, "$1 $2")),
                        (te = X + "{" + te + "}"),
                        (te =
                          B === 1 || (B === 2 && o("@" + te, 3))
                            ? "@-webkit-" + te + "@" + te
                            : "@" + te);
                      break;
                    default:
                      (te = X + te), W === 112 && (te = ((ge += te), ""));
                  }
                else te = "";
                break;
              default:
                te = t(z, n(z, X, mr), te, W, C + 1);
            }
            (il += te),
              (te = mr = _e = Ae = ie = 0),
              (X = ""),
              (K = b.charCodeAt(++re));
            break;
          case 125:
          case 59:
            if (
              ((X = (0 < _e ? X.replace(d, "") : X).trim()),
              1 < (Le = X.length))
            )
              switch (
                (Ae === 0 &&
                  ((ie = X.charCodeAt(0)),
                  ie === 45 || (96 < ie && 123 > ie)) &&
                  (Le = (X = X.replace(" ", ":")).length),
                0 < $ &&
                  (bt = a(1, X, z, _, j, N, ge.length, W, C, W)) !== void 0 &&
                  (Le = (X = bt.trim()).length) === 0 &&
                  (X = "\0\0"),
                (ie = X.charCodeAt(0)),
                (K = X.charCodeAt(1)),
                ie)
              ) {
                case 0:
                  break;
                case 64:
                  if (K === 105 || K === 99) {
                    ol += X + b.charAt(re);
                    break;
                  }
                default:
                  X.charCodeAt(Le - 1) !== 58 &&
                    (ge += i(X, ie, K, X.charCodeAt(2)));
              }
            (mr = _e = Ae = ie = 0), (X = ""), (K = b.charCodeAt(++re));
        }
      }
      switch (K) {
        case 13:
        case 10:
          I === 47
            ? (I = 0)
            : 1 + ie === 0 &&
              W !== 107 &&
              0 < X.length &&
              ((_e = 1), (X += "\0")),
            0 < $ * M && a(0, X, z, _, j, N, ge.length, W, C, W),
            (N = 1),
            j++;
          break;
        case 59:
        case 125:
          if (I + ne + ae + Y === 0) {
            N++;
            break;
          }
        default:
          switch ((N++, (pt = b.charAt(re)), K)) {
            case 9:
            case 32:
              if (ne + Y + I === 0)
                switch ($e) {
                  case 44:
                  case 58:
                  case 9:
                  case 32:
                    pt = "";
                    break;
                  default:
                    K !== 32 && (pt = " ");
                }
              break;
            case 0:
              pt = "\\0";
              break;
            case 12:
              pt = "\\f";
              break;
            case 11:
              pt = "\\v";
              break;
            case 38:
              ne + I + Y === 0 && ((_e = mr = 1), (pt = "\f" + pt));
              break;
            case 108:
              if (ne + I + Y + U === 0 && 0 < Ae)
                switch (re - Ae) {
                  case 2:
                    $e === 112 && b.charCodeAt(re - 3) === 58 && (U = $e);
                  case 8:
                    Ue === 111 && (U = Ue);
                }
              break;
            case 58:
              ne + I + Y === 0 && (Ae = re);
              break;
            case 44:
              I + ae + ne + Y === 0 && ((_e = 1), (pt += "\r"));
              break;
            case 34:
            case 39:
              I === 0 && (ne = ne === K ? 0 : ne === 0 ? K : ne);
              break;
            case 91:
              ne + I + ae === 0 && Y++;
              break;
            case 93:
              ne + I + ae === 0 && Y--;
              break;
            case 41:
              ne + I + Y === 0 && ae--;
              break;
            case 40:
              if (ne + I + Y === 0) {
                if (ie === 0)
                  switch (2 * $e + 3 * Ue) {
                    case 533:
                      break;
                    default:
                      ie = 1;
                  }
                ae++;
              }
              break;
            case 64:
              I + ae + ne + Y + Ae + te === 0 && (te = 1);
              break;
            case 42:
            case 47:
              if (!(0 < ne + Y + ae))
                switch (I) {
                  case 0:
                    switch (2 * K + 3 * b.charCodeAt(re + 1)) {
                      case 235:
                        I = 47;
                        break;
                      case 220:
                        (Le = re), (I = 42);
                    }
                    break;
                  case 42:
                    K === 47 &&
                      $e === 42 &&
                      Le + 2 !== re &&
                      (b.charCodeAt(Le + 2) === 33 &&
                        (ge += b.substring(Le, re + 1)),
                      (pt = ""),
                      (I = 0));
                }
          }
          I === 0 && (X += pt);
      }
      (Ue = $e), ($e = K), re++;
    }
    if (((Le = ge.length), 0 < Le)) {
      if (
        ((_e = z),
        0 < $ &&
          ((bt = a(2, ge, _e, _, j, N, Le, W, C, W)),
          bt !== void 0 && (ge = bt).length === 0))
      )
        return ol + ge + il;
      if (((ge = _e.join(",") + "{" + ge + "}"), B * U !== 0)) {
        switch ((B !== 2 || o(ge, 2) || (U = 0), U)) {
          case 111:
            ge = ge.replace(S, ":-moz-$1") + ge;
            break;
          case 112:
            ge =
              ge.replace(m, "::-webkit-input-$1") +
              ge.replace(m, "::-moz-$1") +
              ge.replace(m, ":-ms-input-$1") +
              ge;
        }
        U = 0;
      }
    }
    return ol + ge + il;
  }
  function n(_, z, b) {
    var W = z.trim().split(x);
    z = W;
    var C = W.length,
      Y = _.length;
    switch (Y) {
      case 0:
      case 1:
        var I = 0;
        for (_ = Y === 0 ? "" : _[0] + " "; I < C; ++I)
          z[I] = r(_, z[I], b).trim();
        break;
      default:
        var ae = (I = 0);
        for (z = []; I < C; ++I)
          for (var ne = 0; ne < Y; ++ne)
            z[ae++] = r(_[ne] + " ", W[I], b).trim();
    }
    return z;
  }
  function r(_, z, b) {
    var W = z.charCodeAt(0);
    switch ((33 > W && (W = (z = z.trim()).charCodeAt(0)), W)) {
      case 38:
        return z.replace(h, "$1" + _.trim());
      case 58:
        return _.trim() + z.replace(h, "$1" + _.trim());
      default:
        if (0 < 1 * b && 0 < z.indexOf("\f"))
          return z.replace(h, (_.charCodeAt(0) === 58 ? "" : "$1") + _.trim());
    }
    return _ + z;
  }
  function i(_, z, b, W) {
    var C = _ + ";",
      Y = 2 * z + 3 * b + 4 * W;
    if (Y === 944) {
      _ = C.indexOf(":", 9) + 1;
      var I = C.substring(_, C.length - 1).trim();
      return (
        (I = C.substring(0, _).trim() + I + ";"),
        B === 1 || (B === 2 && o(I, 1)) ? "-webkit-" + I + I : I
      );
    }
    if (B === 0 || (B === 2 && !o(C, 1))) return C;
    switch (Y) {
      case 1015:
        return C.charCodeAt(10) === 97 ? "-webkit-" + C + C : C;
      case 951:
        return C.charCodeAt(3) === 116 ? "-webkit-" + C + C : C;
      case 963:
        return C.charCodeAt(5) === 110 ? "-webkit-" + C + C : C;
      case 1009:
        if (C.charCodeAt(4) !== 100) break;
      case 969:
      case 942:
        return "-webkit-" + C + C;
      case 978:
        return "-webkit-" + C + "-moz-" + C + C;
      case 1019:
      case 983:
        return "-webkit-" + C + "-moz-" + C + "-ms-" + C + C;
      case 883:
        if (C.charCodeAt(8) === 45) return "-webkit-" + C + C;
        if (0 < C.indexOf("image-set(", 11))
          return C.replace(T, "$1-webkit-$2") + C;
        break;
      case 932:
        if (C.charCodeAt(4) === 45)
          switch (C.charCodeAt(5)) {
            case 103:
              return (
                "-webkit-box-" +
                C.replace("-grow", "") +
                "-webkit-" +
                C +
                "-ms-" +
                C.replace("grow", "positive") +
                C
              );
            case 115:
              return (
                "-webkit-" + C + "-ms-" + C.replace("shrink", "negative") + C
              );
            case 98:
              return (
                "-webkit-" +
                C +
                "-ms-" +
                C.replace("basis", "preferred-size") +
                C
              );
          }
        return "-webkit-" + C + "-ms-" + C + C;
      case 964:
        return "-webkit-" + C + "-ms-flex-" + C + C;
      case 1023:
        if (C.charCodeAt(8) !== 99) break;
        return (
          (I = C.substring(C.indexOf(":", 15))
            .replace("flex-", "")
            .replace("space-between", "justify")),
          "-webkit-box-pack" + I + "-webkit-" + C + "-ms-flex-pack" + I + C
        );
      case 1005:
        return g.test(C)
          ? C.replace(v, ":-webkit-") + C.replace(v, ":-moz-") + C
          : C;
      case 1e3:
        switch (
          ((I = C.substring(13).trim()),
          (z = I.indexOf("-") + 1),
          I.charCodeAt(0) + I.charCodeAt(z))
        ) {
          case 226:
            I = C.replace(w, "tb");
            break;
          case 232:
            I = C.replace(w, "tb-rl");
            break;
          case 220:
            I = C.replace(w, "lr");
            break;
          default:
            return C;
        }
        return "-webkit-" + C + "-ms-" + I + C;
      case 1017:
        if (C.indexOf("sticky", 9) === -1) break;
      case 975:
        switch (
          ((z = (C = _).length - 10),
          (I = (C.charCodeAt(z) === 33 ? C.substring(0, z) : C)
            .substring(_.indexOf(":", 7) + 1)
            .trim()),
          (Y = I.charCodeAt(0) + (I.charCodeAt(7) | 0)))
        ) {
          case 203:
            if (111 > I.charCodeAt(8)) break;
          case 115:
            C = C.replace(I, "-webkit-" + I) + ";" + C;
            break;
          case 207:
          case 102:
            C =
              C.replace(I, "-webkit-" + (102 < Y ? "inline-" : "") + "box") +
              ";" +
              C.replace(I, "-webkit-" + I) +
              ";" +
              C.replace(I, "-ms-" + I + "box") +
              ";" +
              C;
        }
        return C + ";";
      case 938:
        if (C.charCodeAt(5) === 45)
          switch (C.charCodeAt(6)) {
            case 105:
              return (
                (I = C.replace("-items", "")),
                "-webkit-" + C + "-webkit-box-" + I + "-ms-flex-" + I + C
              );
            case 115:
              return "-webkit-" + C + "-ms-flex-item-" + C.replace(k, "") + C;
            default:
              return (
                "-webkit-" +
                C +
                "-ms-flex-line-pack" +
                C.replace("align-content", "").replace(k, "") +
                C
              );
          }
        break;
      case 973:
      case 989:
        if (C.charCodeAt(3) !== 45 || C.charCodeAt(4) === 122) break;
      case 931:
      case 953:
        if (L.test(_) === !0)
          return (I = _.substring(_.indexOf(":") + 1)).charCodeAt(0) === 115
            ? i(_.replace("stretch", "fill-available"), z, b, W).replace(
                ":fill-available",
                ":stretch"
              )
            : C.replace(I, "-webkit-" + I) +
                C.replace(I, "-moz-" + I.replace("fill-", "")) +
                C;
        break;
      case 962:
        if (
          ((C =
            "-webkit-" + C + (C.charCodeAt(5) === 102 ? "-ms-" + C : "") + C),
          b + W === 211 &&
            C.charCodeAt(13) === 105 &&
            0 < C.indexOf("transform", 10))
        )
          return (
            C.substring(0, C.indexOf(";", 27) + 1).replace(y, "$1-webkit-$2") +
            C
          );
    }
    return C;
  }
  function o(_, z) {
    var b = _.indexOf(z === 1 ? ":" : "{"),
      W = _.substring(0, z !== 3 ? b : 10);
    return (
      (b = _.substring(b + 1, _.length - 1)),
      O(z !== 2 ? W : W.replace(D, "$1"), b, z)
    );
  }
  function l(_, z) {
    var b = i(z, z.charCodeAt(0), z.charCodeAt(1), z.charCodeAt(2));
    return b !== z + ";"
      ? b.replace(E, " or ($1)").substring(4)
      : "(" + z + ")";
  }
  function a(_, z, b, W, C, Y, I, ae, ne, ie) {
    for (var K = 0, $e = z, Ue; K < $; ++K)
      switch ((Ue = q[K].call(c, _, $e, b, W, C, Y, I, ae, ne, ie))) {
        case void 0:
        case !1:
        case !0:
        case null:
          break;
        default:
          $e = Ue;
      }
    if ($e !== z) return $e;
  }
  function s(_) {
    switch (_) {
      case void 0:
      case null:
        $ = q.length = 0;
        break;
      default:
        if (typeof _ == "function") q[$++] = _;
        else if (typeof _ == "object")
          for (var z = 0, b = _.length; z < b; ++z) s(_[z]);
        else M = !!_ | 0;
    }
    return s;
  }
  function u(_) {
    return (
      (_ = _.prefix),
      _ !== void 0 &&
        ((O = null),
        _ ? (typeof _ != "function" ? (B = 1) : ((B = 2), (O = _))) : (B = 0)),
      u
    );
  }
  function c(_, z) {
    var b = _;
    if ((33 > b.charCodeAt(0) && (b = b.trim()), (F = b), (b = [F]), 0 < $)) {
      var W = a(-1, z, b, b, j, N, 0, 0, 0, 0);
      W !== void 0 && typeof W == "string" && (z = W);
    }
    var C = t(Z, b, z, 0, 0);
    return (
      0 < $ &&
        ((W = a(-2, C, b, b, j, N, C.length, 0, 0, 0)),
        W !== void 0 && (C = W)),
      (F = ""),
      (U = 0),
      (N = j = 1),
      C
    );
  }
  var f = /^\0+/g,
    d = /[\0\r\f]/g,
    v = /: */g,
    g = /zoo|gra/,
    y = /([,: ])(transform)/g,
    x = /,\r+?/g,
    h = /([\t\r\n ])*\f?&/g,
    p = /@(k\w+)\s*(\S*)\s*/,
    m = /::(place)/g,
    S = /:(read-only)/g,
    w = /[svh]\w+-[tblr]{2}/,
    P = /\(\s*(.*)\s*\)/g,
    E = /([\s\S]*?);/g,
    k = /-self|flex-/g,
    D = /[^]*?(:[rp][el]a[\w-]+)[^]*/,
    L = /stretch|:\s*\w+\-(?:conte|avail)/,
    T = /([^-])(image-set\()/,
    N = 1,
    j = 1,
    U = 0,
    B = 1,
    Z = [],
    q = [],
    $ = 0,
    O = null,
    M = 0,
    F = "";
  return (c.use = s), (c.set = u), e !== void 0 && u(e), c;
}
var zg = {
  animationIterationCount: 1,
  borderImageOutset: 1,
  borderImageSlice: 1,
  borderImageWidth: 1,
  boxFlex: 1,
  boxFlexGroup: 1,
  boxOrdinalGroup: 1,
  columnCount: 1,
  columns: 1,
  flex: 1,
  flexGrow: 1,
  flexPositive: 1,
  flexShrink: 1,
  flexNegative: 1,
  flexOrder: 1,
  gridRow: 1,
  gridRowEnd: 1,
  gridRowSpan: 1,
  gridRowStart: 1,
  gridColumn: 1,
  gridColumnEnd: 1,
  gridColumnSpan: 1,
  gridColumnStart: 1,
  msGridRow: 1,
  msGridRowSpan: 1,
  msGridColumn: 1,
  msGridColumnSpan: 1,
  fontWeight: 1,
  lineHeight: 1,
  opacity: 1,
  order: 1,
  orphans: 1,
  tabSize: 1,
  widows: 1,
  zIndex: 1,
  zoom: 1,
  WebkitLineClamp: 1,
  fillOpacity: 1,
  floodOpacity: 1,
  stopOpacity: 1,
  strokeDasharray: 1,
  strokeDashoffset: 1,
  strokeMiterlimit: 1,
  strokeOpacity: 1,
  strokeWidth: 1,
};
function Rg(e) {
  var t = Object.create(null);
  return function (n) {
    return t[n] === void 0 && (t[n] = e(n)), t[n];
  };
}
var Ig =
    /^((children|dangerouslySetInnerHTML|key|ref|autoFocus|defaultValue|defaultChecked|innerHTML|suppressContentEditableWarning|suppressHydrationWarning|valueLink|abbr|accept|acceptCharset|accessKey|action|allow|allowUserMedia|allowPaymentRequest|allowFullScreen|allowTransparency|alt|async|autoComplete|autoPlay|capture|cellPadding|cellSpacing|challenge|charSet|checked|cite|classID|className|cols|colSpan|content|contentEditable|contextMenu|controls|controlsList|coords|crossOrigin|data|dateTime|decoding|default|defer|dir|disabled|disablePictureInPicture|download|draggable|encType|enterKeyHint|form|formAction|formEncType|formMethod|formNoValidate|formTarget|frameBorder|headers|height|hidden|high|href|hrefLang|htmlFor|httpEquiv|id|inputMode|integrity|is|keyParams|keyType|kind|label|lang|list|loading|loop|low|marginHeight|marginWidth|max|maxLength|media|mediaGroup|method|min|minLength|multiple|muted|name|nonce|noValidate|open|optimum|pattern|placeholder|playsInline|poster|preload|profile|radioGroup|readOnly|referrerPolicy|rel|required|reversed|role|rows|rowSpan|sandbox|scope|scoped|scrolling|seamless|selected|shape|size|sizes|slot|span|spellCheck|src|srcDoc|srcLang|srcSet|start|step|style|summary|tabIndex|target|title|translate|type|useMap|value|width|wmode|wrap|about|datatype|inlist|prefix|property|resource|typeof|vocab|autoCapitalize|autoCorrect|autoSave|color|incremental|fallback|inert|itemProp|itemScope|itemType|itemID|itemRef|on|option|results|security|unselectable|accentHeight|accumulate|additive|alignmentBaseline|allowReorder|alphabetic|amplitude|arabicForm|ascent|attributeName|attributeType|autoReverse|azimuth|baseFrequency|baselineShift|baseProfile|bbox|begin|bias|by|calcMode|capHeight|clip|clipPathUnits|clipPath|clipRule|colorInterpolation|colorInterpolationFilters|colorProfile|colorRendering|contentScriptType|contentStyleType|cursor|cx|cy|d|decelerate|descent|diffuseConstant|direction|display|divisor|dominantBaseline|dur|dx|dy|edgeMode|elevation|enableBackground|end|exponent|externalResourcesRequired|fill|fillOpacity|fillRule|filter|filterRes|filterUnits|floodColor|floodOpacity|focusable|fontFamily|fontSize|fontSizeAdjust|fontStretch|fontStyle|fontVariant|fontWeight|format|from|fr|fx|fy|g1|g2|glyphName|glyphOrientationHorizontal|glyphOrientationVertical|glyphRef|gradientTransform|gradientUnits|hanging|horizAdvX|horizOriginX|ideographic|imageRendering|in|in2|intercept|k|k1|k2|k3|k4|kernelMatrix|kernelUnitLength|kerning|keyPoints|keySplines|keyTimes|lengthAdjust|letterSpacing|lightingColor|limitingConeAngle|local|markerEnd|markerMid|markerStart|markerHeight|markerUnits|markerWidth|mask|maskContentUnits|maskUnits|mathematical|mode|numOctaves|offset|opacity|operator|order|orient|orientation|origin|overflow|overlinePosition|overlineThickness|panose1|paintOrder|pathLength|patternContentUnits|patternTransform|patternUnits|pointerEvents|points|pointsAtX|pointsAtY|pointsAtZ|preserveAlpha|preserveAspectRatio|primitiveUnits|r|radius|refX|refY|renderingIntent|repeatCount|repeatDur|requiredExtensions|requiredFeatures|restart|result|rotate|rx|ry|scale|seed|shapeRendering|slope|spacing|specularConstant|specularExponent|speed|spreadMethod|startOffset|stdDeviation|stemh|stemv|stitchTiles|stopColor|stopOpacity|strikethroughPosition|strikethroughThickness|string|stroke|strokeDasharray|strokeDashoffset|strokeLinecap|strokeLinejoin|strokeMiterlimit|strokeOpacity|strokeWidth|surfaceScale|systemLanguage|tableValues|targetX|targetY|textAnchor|textDecoration|textRendering|textLength|to|transform|u1|u2|underlinePosition|underlineThickness|unicode|unicodeBidi|unicodeRange|unitsPerEm|vAlphabetic|vHanging|vIdeographic|vMathematical|values|vectorEffect|version|vertAdvY|vertOriginX|vertOriginY|viewBox|viewTarget|visibility|widths|wordSpacing|writingMode|x|xHeight|x1|x2|xChannelSelector|xlinkActuate|xlinkArcrole|xlinkHref|xlinkRole|xlinkShow|xlinkTitle|xlinkType|xmlBase|xmlns|xmlnsXlink|xmlLang|xmlSpace|y|y1|y2|yChannelSelector|z|zoomAndPan|for|class|autofocus)|(([Dd][Aa][Tt][Aa]|[Aa][Rr][Ii][Aa]|x)-.*))$/,
  Mc = Rg(function (e) {
    return (
      Ig.test(e) ||
      (e.charCodeAt(0) === 111 &&
        e.charCodeAt(1) === 110 &&
        e.charCodeAt(2) < 91)
    );
  });
function yt() {
  return (yt =
    Object.assign ||
    function (e) {
      for (var t = 1; t < arguments.length; t++) {
        var n = arguments[t];
        for (var r in n)
          Object.prototype.hasOwnProperty.call(n, r) && (e[r] = n[r]);
      }
      return e;
    }).apply(this, arguments);
}
var Nc = function (e, t) {
    for (var n = [e[0]], r = 0, i = t.length; r < i; r += 1)
      n.push(t[r], e[r + 1]);
    return n;
  },
  Bs = function (e) {
    return (
      e !== null &&
      typeof e == "object" &&
      (e.toString ? e.toString() : Object.prototype.toString.call(e)) ===
        "[object Object]" &&
      !Ho.exports.typeOf(e)
    );
  },
  To = Object.freeze([]),
  tn = Object.freeze({});
function lr(e) {
  return typeof e == "function";
}
function Ac(e) {
  return e.displayName || e.name || "Component";
}
function tu(e) {
  return e && typeof e.styledComponentId == "string";
}
var sr =
    (typeof process != "undefined" && ({}.REACT_APP_SC_ATTR || {}.SC_ATTR)) ||
    "data-styled",
  nu = typeof window != "undefined" && "HTMLElement" in window,
  bg = Boolean(
    typeof SC_DISABLE_SPEEDY == "boolean"
      ? SC_DISABLE_SPEEDY
      : typeof process != "undefined" &&
        {}.REACT_APP_SC_DISABLE_SPEEDY !== void 0 &&
        {}.REACT_APP_SC_DISABLE_SPEEDY !== ""
      ? {}.REACT_APP_SC_DISABLE_SPEEDY !== "false" &&
        {}.REACT_APP_SC_DISABLE_SPEEDY
      : typeof process != "undefined" &&
        {}.SC_DISABLE_SPEEDY !== void 0 &&
        {}.SC_DISABLE_SPEEDY !== ""
      ? {}.SC_DISABLE_SPEEDY !== "false" && {}.SC_DISABLE_SPEEDY
      : !1
  ),
  Dg = {};
function Cn(e) {
  for (
    var t = arguments.length, n = new Array(t > 1 ? t - 1 : 0), r = 1;
    r < t;
    r++
  )
    n[r - 1] = arguments[r];
  throw new Error(
    "An error occurred. See https://git.io/JUIaE#" +
      e +
      " for more information." +
      (n.length > 0 ? " Args: " + n.join(", ") : "")
  );
}
var jg = (function () {
    function e(n) {
      (this.groupSizes = new Uint32Array(512)),
        (this.length = 512),
        (this.tag = n);
    }
    var t = e.prototype;
    return (
      (t.indexOfGroup = function (n) {
        for (var r = 0, i = 0; i < n; i++) r += this.groupSizes[i];
        return r;
      }),
      (t.insertRules = function (n, r) {
        if (n >= this.groupSizes.length) {
          for (var i = this.groupSizes, o = i.length, l = o; n >= l; )
            (l <<= 1) < 0 && Cn(16, "" + n);
          (this.groupSizes = new Uint32Array(l)),
            this.groupSizes.set(i),
            (this.length = l);
          for (var a = o; a < l; a++) this.groupSizes[a] = 0;
        }
        for (var s = this.indexOfGroup(n + 1), u = 0, c = r.length; u < c; u++)
          this.tag.insertRule(s, r[u]) && (this.groupSizes[n]++, s++);
      }),
      (t.clearGroup = function (n) {
        if (n < this.length) {
          var r = this.groupSizes[n],
            i = this.indexOfGroup(n),
            o = i + r;
          this.groupSizes[n] = 0;
          for (var l = i; l < o; l++) this.tag.deleteRule(i);
        }
      }),
      (t.getGroup = function (n) {
        var r = "";
        if (n >= this.length || this.groupSizes[n] === 0) return r;
        for (
          var i = this.groupSizes[n],
            o = this.indexOfGroup(n),
            l = o + i,
            a = o;
          a < l;
          a++
        )
          r +=
            this.tag.getRule(a) +
            `/*!sc*/
`;
        return r;
      }),
      e
    );
  })(),
  Ki = new Map(),
  ko = new Map(),
  Fr = 1,
  Ni = function (e) {
    if (Ki.has(e)) return Ki.get(e);
    for (; ko.has(Fr); ) Fr++;
    var t = Fr++;
    return Ki.set(e, t), ko.set(t, e), t;
  },
  Fg = function (e) {
    return ko.get(e);
  },
  Bg = function (e, t) {
    t >= Fr && (Fr = t + 1), Ki.set(e, t), ko.set(t, e);
  },
  Vg = "style[" + sr + '][data-styled-version="5.3.5"]',
  Hg = new RegExp("^" + sr + '\\.g(\\d+)\\[id="([\\w\\d-]+)"\\].*?"([^"]*)'),
  Ug = function (e, t, n) {
    for (var r, i = n.split(","), o = 0, l = i.length; o < l; o++)
      (r = i[o]) && e.registerName(t, r);
  },
  Wg = function (e, t) {
    for (
      var n = (t.textContent || "").split(`/*!sc*/
`),
        r = [],
        i = 0,
        o = n.length;
      i < o;
      i++
    ) {
      var l = n[i].trim();
      if (l) {
        var a = l.match(Hg);
        if (a) {
          var s = 0 | parseInt(a[1], 10),
            u = a[2];
          s !== 0 && (Bg(u, s), Ug(e, u, a[3]), e.getTag().insertRules(s, r)),
            (r.length = 0);
        } else r.push(l);
      }
    }
  },
  Gg = function () {
    return typeof window != "undefined" && window.__webpack_nonce__ !== void 0
      ? window.__webpack_nonce__
      : null;
  },
  Ep = function (e) {
    var t = document.head,
      n = e || t,
      r = document.createElement("style"),
      i = (function (a) {
        for (var s = a.childNodes, u = s.length; u >= 0; u--) {
          var c = s[u];
          if (c && c.nodeType === 1 && c.hasAttribute(sr)) return c;
        }
      })(n),
      o = i !== void 0 ? i.nextSibling : null;
    r.setAttribute(sr, "active"),
      r.setAttribute("data-styled-version", "5.3.5");
    var l = Gg();
    return l && r.setAttribute("nonce", l), n.insertBefore(r, o), r;
  },
  Yg = (function () {
    function e(n) {
      var r = (this.element = Ep(n));
      r.appendChild(document.createTextNode("")),
        (this.sheet = (function (i) {
          if (i.sheet) return i.sheet;
          for (var o = document.styleSheets, l = 0, a = o.length; l < a; l++) {
            var s = o[l];
            if (s.ownerNode === i) return s;
          }
          Cn(17);
        })(r)),
        (this.length = 0);
    }
    var t = e.prototype;
    return (
      (t.insertRule = function (n, r) {
        try {
          return this.sheet.insertRule(r, n), this.length++, !0;
        } catch {
          return !1;
        }
      }),
      (t.deleteRule = function (n) {
        this.sheet.deleteRule(n), this.length--;
      }),
      (t.getRule = function (n) {
        var r = this.sheet.cssRules[n];
        return r !== void 0 && typeof r.cssText == "string" ? r.cssText : "";
      }),
      e
    );
  })(),
  Xg = (function () {
    function e(n) {
      var r = (this.element = Ep(n));
      (this.nodes = r.childNodes), (this.length = 0);
    }
    var t = e.prototype;
    return (
      (t.insertRule = function (n, r) {
        if (n <= this.length && n >= 0) {
          var i = document.createTextNode(r),
            o = this.nodes[n];
          return this.element.insertBefore(i, o || null), this.length++, !0;
        }
        return !1;
      }),
      (t.deleteRule = function (n) {
        this.element.removeChild(this.nodes[n]), this.length--;
      }),
      (t.getRule = function (n) {
        return n < this.length ? this.nodes[n].textContent : "";
      }),
      e
    );
  })(),
  Qg = (function () {
    function e(n) {
      (this.rules = []), (this.length = 0);
    }
    var t = e.prototype;
    return (
      (t.insertRule = function (n, r) {
        return (
          n <= this.length && (this.rules.splice(n, 0, r), this.length++, !0)
        );
      }),
      (t.deleteRule = function (n) {
        this.rules.splice(n, 1), this.length--;
      }),
      (t.getRule = function (n) {
        return n < this.length ? this.rules[n] : "";
      }),
      e
    );
  })(),
  zc = nu,
  Kg = { isServer: !nu, useCSSOMInjection: !bg },
  Po = (function () {
    function e(n, r, i) {
      n === void 0 && (n = tn),
        r === void 0 && (r = {}),
        (this.options = yt({}, Kg, {}, n)),
        (this.gs = r),
        (this.names = new Map(i)),
        (this.server = !!n.isServer),
        !this.server &&
          nu &&
          zc &&
          ((zc = !1),
          (function (o) {
            for (
              var l = document.querySelectorAll(Vg), a = 0, s = l.length;
              a < s;
              a++
            ) {
              var u = l[a];
              u &&
                u.getAttribute(sr) !== "active" &&
                (Wg(o, u), u.parentNode && u.parentNode.removeChild(u));
            }
          })(this));
    }
    e.registerId = function (n) {
      return Ni(n);
    };
    var t = e.prototype;
    return (
      (t.reconstructWithOptions = function (n, r) {
        return (
          r === void 0 && (r = !0),
          new e(
            yt({}, this.options, {}, n),
            this.gs,
            (r && this.names) || void 0
          )
        );
      }),
      (t.allocateGSInstance = function (n) {
        return (this.gs[n] = (this.gs[n] || 0) + 1);
      }),
      (t.getTag = function () {
        return (
          this.tag ||
          (this.tag =
            ((i = (r = this.options).isServer),
            (o = r.useCSSOMInjection),
            (l = r.target),
            (n = i ? new Qg(l) : o ? new Yg(l) : new Xg(l)),
            new jg(n)))
        );
        var n, r, i, o, l;
      }),
      (t.hasNameForId = function (n, r) {
        return this.names.has(n) && this.names.get(n).has(r);
      }),
      (t.registerName = function (n, r) {
        if ((Ni(n), this.names.has(n))) this.names.get(n).add(r);
        else {
          var i = new Set();
          i.add(r), this.names.set(n, i);
        }
      }),
      (t.insertRules = function (n, r, i) {
        this.registerName(n, r), this.getTag().insertRules(Ni(n), i);
      }),
      (t.clearNames = function (n) {
        this.names.has(n) && this.names.get(n).clear();
      }),
      (t.clearRules = function (n) {
        this.getTag().clearGroup(Ni(n)), this.clearNames(n);
      }),
      (t.clearTag = function () {
        this.tag = void 0;
      }),
      (t.toString = function () {
        return (function (n) {
          for (var r = n.getTag(), i = r.length, o = "", l = 0; l < i; l++) {
            var a = Fg(l);
            if (a !== void 0) {
              var s = n.names.get(a),
                u = r.getGroup(l);
              if (s && u && s.size) {
                var c = sr + ".g" + l + '[id="' + a + '"]',
                  f = "";
                s !== void 0 &&
                  s.forEach(function (d) {
                    d.length > 0 && (f += d + ",");
                  }),
                  (o +=
                    "" +
                    u +
                    c +
                    '{content:"' +
                    f +
                    `"}/*!sc*/
`);
              }
            }
          }
          return o;
        })(this);
      }),
      e
    );
  })(),
  Zg = /(a)(d)/gi,
  Rc = function (e) {
    return String.fromCharCode(e + (e > 25 ? 39 : 97));
  };
function Vs(e) {
  var t,
    n = "";
  for (t = Math.abs(e); t > 52; t = (t / 52) | 0) n = Rc(t % 52) + n;
  return (Rc(t % 52) + n).replace(Zg, "$1-$2");
}
var Vn = function (e, t) {
    for (var n = t.length; n; ) e = (33 * e) ^ t.charCodeAt(--n);
    return e;
  },
  Tp = function (e) {
    return Vn(5381, e);
  };
function kp(e) {
  for (var t = 0; t < e.length; t += 1) {
    var n = e[t];
    if (lr(n) && !tu(n)) return !1;
  }
  return !0;
}
var qg = Tp("5.3.5"),
  Jg = (function () {
    function e(t, n, r) {
      (this.rules = t),
        (this.staticRulesId = ""),
        (this.isStatic = (r === void 0 || r.isStatic) && kp(t)),
        (this.componentId = n),
        (this.baseHash = Vn(qg, n)),
        (this.baseStyle = r),
        Po.registerId(n);
    }
    return (
      (e.prototype.generateAndInjectStyles = function (t, n, r) {
        var i = this.componentId,
          o = [];
        if (
          (this.baseStyle &&
            o.push(this.baseStyle.generateAndInjectStyles(t, n, r)),
          this.isStatic && !r.hash)
        )
          if (this.staticRulesId && n.hasNameForId(i, this.staticRulesId))
            o.push(this.staticRulesId);
          else {
            var l = En(this.rules, t, n, r).join(""),
              a = Vs(Vn(this.baseHash, l) >>> 0);
            if (!n.hasNameForId(i, a)) {
              var s = r(l, "." + a, void 0, i);
              n.insertRules(i, a, s);
            }
            o.push(a), (this.staticRulesId = a);
          }
        else {
          for (
            var u = this.rules.length,
              c = Vn(this.baseHash, r.hash),
              f = "",
              d = 0;
            d < u;
            d++
          ) {
            var v = this.rules[d];
            if (typeof v == "string") f += v;
            else if (v) {
              var g = En(v, t, n, r),
                y = Array.isArray(g) ? g.join("") : g;
              (c = Vn(c, y + d)), (f += y);
            }
          }
          if (f) {
            var x = Vs(c >>> 0);
            if (!n.hasNameForId(i, x)) {
              var h = r(f, "." + x, void 0, i);
              n.insertRules(i, x, h);
            }
            o.push(x);
          }
        }
        return o.join(" ");
      }),
      e
    );
  })(),
  e0 = /^\s*\/\/.*$/gm,
  t0 = [":", "[", ".", "#"];
function n0(e) {
  var t,
    n,
    r,
    i,
    o = e === void 0 ? tn : e,
    l = o.options,
    a = l === void 0 ? tn : l,
    s = o.plugins,
    u = s === void 0 ? To : s,
    c = new Ag(a),
    f = [],
    d = (function (y) {
      function x(h) {
        if (h)
          try {
            y(h + "}");
          } catch {}
      }
      return function (h, p, m, S, w, P, E, k, D, L) {
        switch (h) {
          case 1:
            if (D === 0 && p.charCodeAt(0) === 64) return y(p + ";"), "";
            break;
          case 2:
            if (k === 0) return p + "/*|*/";
            break;
          case 3:
            switch (k) {
              case 102:
              case 112:
                return y(m[0] + p), "";
              default:
                return p + (L === 0 ? "/*|*/" : "");
            }
          case -2:
            p.split("/*|*/}").forEach(x);
        }
      };
    })(function (y) {
      f.push(y);
    }),
    v = function (y, x, h) {
      return (x === 0 && t0.indexOf(h[n.length]) !== -1) || h.match(i)
        ? y
        : "." + t;
    };
  function g(y, x, h, p) {
    p === void 0 && (p = "&");
    var m = y.replace(e0, ""),
      S = x && h ? h + " " + x + " { " + m + " }" : m;
    return (
      (t = p),
      (n = x),
      (r = new RegExp("\\" + n + "\\b", "g")),
      (i = new RegExp("(\\" + n + "\\b){2,}")),
      c(h || !x ? "" : x, S)
    );
  }
  return (
    c.use(
      [].concat(u, [
        function (y, x, h) {
          y === 2 &&
            h.length &&
            h[0].lastIndexOf(n) > 0 &&
            (h[0] = h[0].replace(r, v));
        },
        d,
        function (y) {
          if (y === -2) {
            var x = f;
            return (f = []), x;
          }
        },
      ])
    ),
    (g.hash = u.length
      ? u
          .reduce(function (y, x) {
            return x.name || Cn(15), Vn(y, x.name);
          }, 5381)
          .toString()
      : ""),
    g
  );
}
var Pp = Q.createContext();
Pp.Consumer;
var $p = Q.createContext(),
  r0 = ($p.Consumer, new Po()),
  Hs = n0();
function _p() {
  return A.exports.useContext(Pp) || r0;
}
function Lp() {
  return A.exports.useContext($p) || Hs;
}
var Op = (function () {
    function e(t, n) {
      var r = this;
      (this.inject = function (i, o) {
        o === void 0 && (o = Hs);
        var l = r.name + o.hash;
        i.hasNameForId(r.id, l) ||
          i.insertRules(r.id, l, o(r.rules, l, "@keyframes"));
      }),
        (this.toString = function () {
          return Cn(12, String(r.name));
        }),
        (this.name = t),
        (this.id = "sc-keyframes-" + t),
        (this.rules = n);
    }
    return (
      (e.prototype.getName = function (t) {
        return t === void 0 && (t = Hs), this.name + t.hash;
      }),
      e
    );
  })(),
  i0 = /([A-Z])/,
  o0 = /([A-Z])/g,
  l0 = /^ms-/,
  s0 = function (e) {
    return "-" + e.toLowerCase();
  };
function Ic(e) {
  return i0.test(e) ? e.replace(o0, s0).replace(l0, "-ms-") : e;
}
var bc = function (e) {
  return e == null || e === !1 || e === "";
};
function En(e, t, n, r) {
  if (Array.isArray(e)) {
    for (var i, o = [], l = 0, a = e.length; l < a; l += 1)
      (i = En(e[l], t, n, r)) !== "" &&
        (Array.isArray(i) ? o.push.apply(o, i) : o.push(i));
    return o;
  }
  if (bc(e)) return "";
  if (tu(e)) return "." + e.styledComponentId;
  if (lr(e)) {
    if (
      typeof (u = e) != "function" ||
      (u.prototype && u.prototype.isReactComponent) ||
      !t
    )
      return e;
    var s = e(t);
    return En(s, t, n, r);
  }
  var u;
  return e instanceof Op
    ? n
      ? (e.inject(n, r), e.getName(r))
      : e
    : Bs(e)
    ? (function c(f, d) {
        var v,
          g,
          y = [];
        for (var x in f)
          f.hasOwnProperty(x) &&
            !bc(f[x]) &&
            ((Array.isArray(f[x]) && f[x].isCss) || lr(f[x])
              ? y.push(Ic(x) + ":", f[x], ";")
              : Bs(f[x])
              ? y.push.apply(y, c(f[x], x))
              : y.push(
                  Ic(x) +
                    ": " +
                    ((v = x),
                    (g = f[x]) == null || typeof g == "boolean" || g === ""
                      ? ""
                      : typeof g != "number" || g === 0 || v in zg
                      ? String(g).trim()
                      : g + "px") +
                    ";"
                ));
        return d ? [d + " {"].concat(y, ["}"]) : y;
      })(e)
    : e.toString();
}
var Dc = function (e) {
  return Array.isArray(e) && (e.isCss = !0), e;
};
function hr(e) {
  for (
    var t = arguments.length, n = new Array(t > 1 ? t - 1 : 0), r = 1;
    r < t;
    r++
  )
    n[r - 1] = arguments[r];
  return lr(e) || Bs(e)
    ? Dc(En(Nc(To, [e].concat(n))))
    : n.length === 0 && e.length === 1 && typeof e[0] == "string"
    ? e
    : Dc(En(Nc(e, n)));
}
var Mp = function (e, t, n) {
    return (
      n === void 0 && (n = tn), (e.theme !== n.theme && e.theme) || t || n.theme
    );
  },
  a0 = /[!"#$%&'()*+,./:;<=>?@[\\\]^`{|}~-]+/g,
  u0 = /(^-|-$)/g;
function bl(e) {
  return e.replace(a0, "-").replace(u0, "");
}
var ru = function (e) {
  return Vs(Tp(e) >>> 0);
};
function Ai(e) {
  return typeof e == "string" && !0;
}
var Us = function (e) {
    return (
      typeof e == "function" ||
      (typeof e == "object" && e !== null && !Array.isArray(e))
    );
  },
  c0 = function (e) {
    return e !== "__proto__" && e !== "constructor" && e !== "prototype";
  };
function f0(e, t, n) {
  var r = e[n];
  Us(t) && Us(r) ? Np(r, t) : (e[n] = t);
}
function Np(e) {
  for (
    var t = arguments.length, n = new Array(t > 1 ? t - 1 : 0), r = 1;
    r < t;
    r++
  )
    n[r - 1] = arguments[r];
  for (var i = 0, o = n; i < o.length; i++) {
    var l = o[i];
    if (Us(l)) for (var a in l) c0(a) && f0(e, l[a], a);
  }
  return e;
}
var oi = Q.createContext();
oi.Consumer;
function d0(e) {
  var t = A.exports.useContext(oi),
    n = A.exports.useMemo(
      function () {
        return (function (r, i) {
          if (!r) return Cn(14);
          if (lr(r)) {
            var o = r(i);
            return o;
          }
          return Array.isArray(r) || typeof r != "object"
            ? Cn(8)
            : i
            ? yt({}, i, {}, r)
            : r;
        })(e.theme, t);
      },
      [e.theme, t]
    );
  return e.children
    ? Q.createElement(oi.Provider, { value: n }, e.children)
    : null;
}
var Dl = {};
function Ap(e, t, n) {
  var r = tu(e),
    i = !Ai(e),
    o = t.attrs,
    l = o === void 0 ? To : o,
    a = t.componentId,
    s =
      a === void 0
        ? (function (p, m) {
            var S = typeof p != "string" ? "sc" : bl(p);
            Dl[S] = (Dl[S] || 0) + 1;
            var w = S + "-" + ru("5.3.5" + S + Dl[S]);
            return m ? m + "-" + w : w;
          })(t.displayName, t.parentComponentId)
        : a,
    u = t.displayName,
    c =
      u === void 0
        ? (function (p) {
            return Ai(p) ? "styled." + p : "Styled(" + Ac(p) + ")";
          })(e)
        : u,
    f =
      t.displayName && t.componentId
        ? bl(t.displayName) + "-" + t.componentId
        : t.componentId || s,
    d = r && e.attrs ? Array.prototype.concat(e.attrs, l).filter(Boolean) : l,
    v = t.shouldForwardProp;
  r &&
    e.shouldForwardProp &&
    (v = t.shouldForwardProp
      ? function (p, m, S) {
          return e.shouldForwardProp(p, m, S) && t.shouldForwardProp(p, m, S);
        }
      : e.shouldForwardProp);
  var g,
    y = new Jg(n, f, r ? e.componentStyle : void 0),
    x = y.isStatic && l.length === 0,
    h = function (p, m) {
      return (function (S, w, P, E) {
        var k = S.attrs,
          D = S.componentStyle,
          L = S.defaultProps,
          T = S.foldedComponentIds,
          N = S.shouldForwardProp,
          j = S.styledComponentId,
          U = S.target,
          B = (function (W, C, Y) {
            W === void 0 && (W = tn);
            var I = yt({}, C, { theme: W }),
              ae = {};
            return (
              Y.forEach(function (ne) {
                var ie,
                  K,
                  $e,
                  Ue = ne;
                for (ie in (lr(Ue) && (Ue = Ue(I)), Ue))
                  I[ie] = ae[ie] =
                    ie === "className"
                      ? ((K = ae[ie]),
                        ($e = Ue[ie]),
                        K && $e ? K + " " + $e : K || $e)
                      : Ue[ie];
              }),
              [I, ae]
            );
          })(Mp(w, A.exports.useContext(oi), L) || tn, w, k),
          Z = B[0],
          q = B[1],
          $ = (function (W, C, Y, I) {
            var ae = _p(),
              ne = Lp(),
              ie = C
                ? W.generateAndInjectStyles(tn, ae, ne)
                : W.generateAndInjectStyles(Y, ae, ne);
            return ie;
          })(D, E, Z),
          O = P,
          M = q.$as || w.$as || q.as || w.as || U,
          F = Ai(M),
          _ = q !== w ? yt({}, w, {}, q) : w,
          z = {};
        for (var b in _)
          b[0] !== "$" &&
            b !== "as" &&
            (b === "forwardedAs"
              ? (z.as = _[b])
              : (N ? N(b, Mc, M) : !F || Mc(b)) && (z[b] = _[b]));
        return (
          w.style &&
            q.style !== w.style &&
            (z.style = yt({}, w.style, {}, q.style)),
          (z.className = Array.prototype
            .concat(T, j, $ !== j ? $ : null, w.className, q.className)
            .filter(Boolean)
            .join(" ")),
          (z.ref = O),
          A.exports.createElement(M, z)
        );
      })(g, p, m, x);
    };
  return (
    (h.displayName = c),
    ((g = Q.forwardRef(h)).attrs = d),
    (g.componentStyle = y),
    (g.displayName = c),
    (g.shouldForwardProp = v),
    (g.foldedComponentIds = r
      ? Array.prototype.concat(e.foldedComponentIds, e.styledComponentId)
      : To),
    (g.styledComponentId = f),
    (g.target = r ? e.target : e),
    (g.withComponent = function (p) {
      var m = t.componentId,
        S = (function (P, E) {
          if (P == null) return {};
          var k,
            D,
            L = {},
            T = Object.keys(P);
          for (D = 0; D < T.length; D++)
            (k = T[D]), E.indexOf(k) >= 0 || (L[k] = P[k]);
          return L;
        })(t, ["componentId"]),
        w = m && m + "-" + (Ai(p) ? p : bl(Ac(p)));
      return Ap(p, yt({}, S, { attrs: d, componentId: w }), n);
    }),
    Object.defineProperty(g, "defaultProps", {
      get: function () {
        return this._foldedDefaultProps;
      },
      set: function (p) {
        this._foldedDefaultProps = r ? Np({}, e.defaultProps, p) : p;
      },
    }),
    (g.toString = function () {
      return "." + g.styledComponentId;
    }),
    i &&
      gg(g, e, {
        attrs: !0,
        componentStyle: !0,
        displayName: !0,
        foldedComponentIds: !0,
        shouldForwardProp: !0,
        styledComponentId: !0,
        target: !0,
        withComponent: !0,
      }),
    g
  );
}
var Ws = function (e) {
  return (function t(n, r, i) {
    if ((i === void 0 && (i = tn), !Ho.exports.isValidElementType(r)))
      return Cn(1, String(r));
    var o = function () {
      return n(r, i, hr.apply(void 0, arguments));
    };
    return (
      (o.withConfig = function (l) {
        return t(n, r, yt({}, i, {}, l));
      }),
      (o.attrs = function (l) {
        return t(
          n,
          r,
          yt({}, i, {
            attrs: Array.prototype.concat(i.attrs, l).filter(Boolean),
          })
        );
      }),
      o
    );
  })(Ap, e);
};
[
  "a",
  "abbr",
  "address",
  "area",
  "article",
  "aside",
  "audio",
  "b",
  "base",
  "bdi",
  "bdo",
  "big",
  "blockquote",
  "body",
  "br",
  "button",
  "canvas",
  "caption",
  "cite",
  "code",
  "col",
  "colgroup",
  "data",
  "datalist",
  "dd",
  "del",
  "details",
  "dfn",
  "dialog",
  "div",
  "dl",
  "dt",
  "em",
  "embed",
  "fieldset",
  "figcaption",
  "figure",
  "footer",
  "form",
  "h1",
  "h2",
  "h3",
  "h4",
  "h5",
  "h6",
  "head",
  "header",
  "hgroup",
  "hr",
  "html",
  "i",
  "iframe",
  // "img",
  "input",
  "ins",
  "kbd",
  "keygen",
  "label",
  "legend",
  "li",
  "link",
  "main",
  "map",
  "mark",
  "marquee",
  "menu",
  "menuitem",
  "meta",
  "meter",
  "nav",
  "noscript",
  "object",
  "ol",
  "optgroup",
  "option",
  "output",
  "p",
  "param",
  "picture",
  "pre",
  "progress",
  "q",
  "rp",
  "rt",
  "ruby",
  "s",
  "samp",
  "script",
  "section",
  "select",
  "small",
  "source",
  "span",
  "strong",
  "style",
  "sub",
  "summary",
  "sup",
  "table",
  "tbody",
  "td",
  "textarea",
  "tfoot",
  "th",
  "thead",
  "time",
  "title",
  "tr",
  "track",
  "u",
  "ul",
  "var",
  "video",
  "wbr",
  "circle",
  "clipPath",
  "defs",
  "ellipse",
  "foreignObject",
  "g",
  "image",
  "line",
  "linearGradient",
  "marker",
  "mask",
  "path",
  "pattern",
  "polygon",
  "polyline",
  "radialGradient",
  "rect",
  "stop",
  "svg",
  "text",
  "textPath",
  "tspan",
].forEach(function (e) {
  Ws[e] = Ws(e);
});
var p0 = (function () {
  function e(n, r) {
    (this.rules = n),
      (this.componentId = r),
      (this.isStatic = kp(n)),
      Po.registerId(this.componentId + 1);
  }
  var t = e.prototype;
  return (
    (t.createStyles = function (n, r, i, o) {
      var l = o(En(this.rules, r, i, o).join(""), ""),
        a = this.componentId + n;
      i.insertRules(a, a, l);
    }),
    (t.removeStyles = function (n, r) {
      r.clearRules(this.componentId + n);
    }),
    (t.renderStyles = function (n, r, i, o) {
      n > 2 && Po.registerId(this.componentId + n),
        this.removeStyles(n, i),
        this.createStyles(n, r, i, o);
    }),
    e
  );
})();
function h0(e) {
  for (
    var t = arguments.length, n = new Array(t > 1 ? t - 1 : 0), r = 1;
    r < t;
    r++
  )
    n[r - 1] = arguments[r];
  var i = hr.apply(void 0, [e].concat(n)),
    o = "sc-global-" + ru(JSON.stringify(i)),
    l = new p0(i, o);
  function a(u) {
    var c = _p(),
      f = Lp(),
      d = A.exports.useContext(oi),
      v = A.exports.useRef(c.allocateGSInstance(o)).current;
    return (
      c.server && s(v, u, c, d, f),
      A.exports.useLayoutEffect(
        function () {
          if (!c.server)
            return (
              s(v, u, c, d, f),
              function () {
                return l.removeStyles(v, c);
              }
            );
        },
        [v, u, c, d, f]
      ),
      null
    );
  }
  function s(u, c, f, d, v) {
    if (l.isStatic) l.renderStyles(u, Dg, f, v);
    else {
      var g = yt({}, c, { theme: Mp(c, d, a.defaultProps) });
      l.renderStyles(u, g, f, v);
    }
  }
  return Q.memo(a);
}
function m0(e) {
  for (
    var t = arguments.length, n = new Array(t > 1 ? t - 1 : 0), r = 1;
    r < t;
    r++
  )
    n[r - 1] = arguments[r];
  var i = hr.apply(void 0, [e].concat(n)).join(""),
    o = ru(i);
  return new Op(o, i);
}
var me = Ws;
const zp = () => !window.invokeNative,
  v0 = () => {},
  iu = (e, t) => {
    const n = A.exports.useRef(v0);
    A.exports.useEffect(() => {
      n.current = t;
    }, [t]),
      A.exports.useEffect(() => {
        const r = (i) => {
          const { action: o, data: l } = i.data;
          n.current && o === e && n.current(l);
        };
        return (
          window.addEventListener("message", r),
          () => window.removeEventListener("message", r)
        );
      }, [e]);
  };
async function mn(e, t, n) {
  const r = {
    method: "post",
    headers: { "Content-Type": "application/json; charset=UTF-8" },
    body: JSON.stringify(t),
  };
  if (zp() && n) return n;
  const i = window.GetParentResourceName
    ? window.GetParentResourceName()
    : "nui-frame-app";
  return await (await fetch(`https://${i}/${e}`, r));
}
var tl = { exports: {} },
  nl = {};
/**
 * @license React
 * react-jsx-runtime.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */ var g0 = A.exports,
  y0 = Symbol.for("react.element"),
  S0 = Symbol.for("react.fragment"),
  w0 = Object.prototype.hasOwnProperty,
  x0 = g0.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED.ReactCurrentOwner,
  C0 = { key: !0, ref: !0, __self: !0, __source: !0 };
function Rp(e, t, n) {
  var r,
    i = {},
    o = null,
    l = null;
  n !== void 0 && (o = "" + n),
    t.key !== void 0 && (o = "" + t.key),
    t.ref !== void 0 && (l = t.ref);
  for (r in t) w0.call(t, r) && !C0.hasOwnProperty(r) && (i[r] = t[r]);
  if (e && e.defaultProps)
    for (r in ((t = e.defaultProps), t)) i[r] === void 0 && (i[r] = t[r]);
  return {
    $$typeof: y0,
    type: e,
    key: o,
    ref: l,
    props: i,
    _owner: x0.current,
  };
}
nl.Fragment = S0;
nl.jsx = Rp;
nl.jsxs = Rp;
tl.exports = nl;
const G = tl.exports.jsx,
  Te = tl.exports.jsxs,
  li = tl.exports.Fragment,
  Ip = A.exports.createContext(null),
  E0 = ({ children: e }) => {
    const [t, n] = A.exports.useState(!1);
    return (
      iu("Visible", n),
      A.exports.useEffect(() => {
        if (!t) return;
        const r = (i) => {
          ["Escape"].includes(i.code) && (zp() ? n(!t) : mn("Close"));
        };
        return (
          window.addEventListener("keydown", r),
          () => window.removeEventListener("keydown", r)
        );
      }, [t]),
      G(Ip.Provider, {
        value: { visible: t, setVisible: n },
        children: G("div", {
          style: { visibility: t ? "visible" : "hidden" },
          children: e,
        }),
      })
    );
  },
  T0 = () => A.exports.useContext(Ip);
var k0 = h0`
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        outline: none;
        border: none;
        user-select: none;
        
        font-family: 'Poppins', sans-serif;
        -webkit-font-smoothing: antialiased;
    }
    
    body {
        color: ${({ theme: e }) => e.COLORS.WHITE};

        overflow-y: hidden;
        overflow-x: hidden;

        width: 100vw; 
        height: 100vh; 
    }
    
    button {
        cursor: pointer;
    }
    
    :root {
        font-size: 16px;
    }
    
    @media screen and (max-width: 800px), screen and (max-height: 600px) {
        :root {
            font-size: 0.3rem;
        }
    }

    @media screen and (min-width: 800px) and (min-height: 600px) {
        :root {
            font-size: 0.425rem;
        }
    }

    @media screen and (min-width: 1000px) and (min-height: 700px) {
        :root {
            font-size: 0.55rem;
        }
    }

    @media screen and (min-width: 1100px) and (min-height: 700px) {
        :root {
            font-size: 0.6rem;
        }
    }

    @media screen and (min-width: 1300px) and (min-height: 700px) {
        :root {
            font-size: 0.7rem;
        }
    }

    @media screen and (min-width: 1400px) and (min-height: 700px) {
        :root {
            font-size: 0.75rem;
        }
    }

    @media screen and (min-width: 1600px) and (min-height: 800px) {
        :root {
            font-size: 0.8rem;
        }
    }

    @media screen and (min-width: 1750px) and (min-height: 900px) {
        :root {
            font-size: 0.9rem;
        }
    }

    @media screen and (min-width: 1850px) and (min-height: 1000px) {
        :root {
            font-size: 1rem;
        }
    }
`,
  P0 = {
    COLORS: {
      WHITE: "#FFFFFF",
      GRAY_20: "rgba(255, 255, 255, 0.2)",
      BLACK_20: "rgba(0, 0, 0, 0.3)",
      BLACK_30: "rgba(0, 0, 0, 0.4)",
      BLACK_50: "rgba(0, 0, 0, 0.5)",
      BLACK_55: "rgba(0, 0, 0, 0.5)",
      BLACK_60: "rgba(0, 0, 0, 0.7)",
      BLACK_70: "rgba(0, 0, 0, 0.8)",
      BLACK_80: "rgba(0, 0, 0, 0.9)",
      YELLOW_10: "rgb(59 130 246 / .1)",
      YELLOW_20: "rgb(59 130 246 / .2)",
      YELLOW_40: "rgb(59 130 246 / .4)",
      YELLOW_60: "rgb(59 130 246 / .6)",
      YELLOW_80: "rgb(59 130 246 / .8)",
      YELLOW_100: "rgb(59 130 246 / .8)",
    },
  };
const bp = A.exports.createContext(null),
  $0 = ({ children: e }) => {
    const [t, n] = A.exports.useState(null),
      r = (i) => {
        n(i);
      };
    return G(bp.Provider, {
      value: { vehicle: t, setVehicle: r },
      children: e,
    });
  },
  Dp = () => A.exports.useContext(bp),
  _0 = me.section` 
    width: 100%; 
    height: 4.5rem;

    display: grid; 
    grid-template-columns: repeat(2, 1fr);
    grid-template-rows: 1fr; 
`,
  jc = me.button` 
    font-family: 'Poppins';
    font-style: normal;
    font-weight: 500;
    font-size: 1.25rem;
    line-height: 1.875rem;

    color: ${(e) =>
      e.city ? "rgba(34, 232, 235, 1)" : "rgba(59, 130, 246, 1)"};

    background: ${({ theme: e }) => e.COLORS.BLACK_55};

    :hover {
        background: ${({ theme: e }) => e.COLORS.BLACK_60};
    }
`;
function L0({ city: e }) {
  const { vehicle: t } = Dp(),
    n = (i) => {
      const o = { model: i.model };
      mn("takeVehicle", o).catch(() => {
      
      });
    },
    r = () => {
      mn("storeVehicle").catch(() => {
      
      });
    };
  return Te(_0, {
    children: [
      G(jc, {
        city: e === "hensa",
        onClick: () => t && n(t),
        disabled: !t,
        children: "PEGAR",
      }),
      G(jc, { city: e === "hensa", onClick: () => r(), children: "GUARDAR" }),
    ],
  });
}
var O0 = "./assets/background.485be87f.png",
  M0 = "./assets/background-hensa.d18d7f19.png";
const N0 = me.main`
    width: 100vw;
    height: 100vh;

    background: url(${(e) => (e.city === "hensa" ? M0 : O0)});
    background-position: center; 
    background-repeat: no-repeat; 
    background-size: 100% 100%; 

    transition: opacity 200ms; 

    ${({ visible: e }) => hr`
        opacity: ${e ? 1 : 0};
    `}
`;
var Fc = [
  { "id": 1, "label": "Todos", "type": null },
  { "id": 2, "label": "Carros", "type": "Cars" },
  { "id": 3, "label": "Motos", "type": "Bikes" },
  { "id": 4, "label": "Alugados", "type": "Rental" }
];
const jp = A.exports.createContext(null),
  A0 = ({ children: e }) => {
    const [t, n] = A.exports.useState(""),
      [r, i] = A.exports.useState(Fc[0]),
      o = (a) => {
        n(a);
      },
      l = (a) => {
        i(a);
      };
    return G(jp.Provider, {
      value: {
        CATEGORIES: Fc,
        search: t,
        category: r,
        setSearch: o,
        setCategory: l,
      },
      children: e,
    });
  },
  ou = () => A.exports.useContext(jp),
  z0 = me.button`
    font-family: 'Poppins', sans-serif;
    font-style: normal;
    font-weight: 500;
    font-size: 1rem;
    line-height: 1.5rem;
    
    ${({ active: e, theme: t }) => hr` 
        color: ${e ? t.COLORS.WHITE : t.COLORS.GRAY_20};
        background: ${e ? t.COLORS.BLACK_60 : t.COLORS.BLACK_55};
    `}
`;
function R0({ label: e, onClick: t, active: n }) {
  return G(z0, { active: n, onClick: t, children: e });
}
const I0 = me.section` 
    width: 100%; 
    height: 2.375rem;

    display: grid;
    grid-template-columns: repeat(${({ columns: e }) => e}, 1fr); 
    grid-template-rows: 1fr;
`;
function b0() {
  const { category: e, setCategory: t, CATEGORIES: n } = ou(),
    r = (i) => {
      t(i);
    };
  return G(I0, {
    columns: n.length,
    children: n.map((i) =>
      G(
        R0,
        { label: i.label, onClick: () => r(i), active: e.id === i.id },
        i.id
      )
    ),
  });
}
var D0 = "./assets/search.5a053a2a.svg";
const j0 = me.input` 
    width: 100%;
    padding: 0.75rem 2.125rem 0.75rem 5.125rem;

    background: ${(e) =>
      e.city ? "rgba(4, 181, 185, 0.4)" : "rgba(0, 0, 0, 0.5)"} url(${D0});
    background-size: 1.5rem 1.5rem; 
    background-position: 2.125rem center; 
    background-repeat: no-repeat; 

    border-radius: 0.5rem 0.5rem 0 0;

    font-family: 'Poppins', sans-serif;
    font-style: normal;
    font-weight: 500;
    font-size: 1.25rem;
    line-height: 1.875rem;

    color: rgba(255, 255, 255, 1);

    ::-webkit-input-placeholder {
        color: rgba(255, 255, 255, 0.2);
    }

    ::-webkit-search-cancel-button {
        display: none;
    }
`;
function F0({ placeHolder: e, city: t }) {
  const { search: n, setSearch: r } = ou();
  return G(j0, {
    city: t === "hensa",
    type: "search",
    spellCheck: !1,
    placeholder: e,
    value: n,
    onChange: ({ target: i }) => r(i.value),
  });
}
function Bc(e) {
  return (
    e !== null &&
    typeof e == "object" &&
    "constructor" in e &&
    e.constructor === Object
  );
}
function lu(e = {}, t = {}) {
  Object.keys(t).forEach((n) => {
    typeof e[n] == "undefined"
      ? (e[n] = t[n])
      : Bc(t[n]) && Bc(e[n]) && Object.keys(t[n]).length > 0 && lu(e[n], t[n]);
  });
}
const Fp = {
  body: {},
  addEventListener() {},
  removeEventListener() {},
  activeElement: { blur() {}, nodeName: "" },
  querySelector() {
    return null;
  },
  querySelectorAll() {
    return [];
  },
  getElementById() {
    return null;
  },
  createEvent() {
    return { initEvent() {} };
  },
  createElement() {
    return {
      children: [],
      childNodes: [],
      style: {},
      setAttribute() {},
      getElementsByTagName() {
        return [];
      },
    };
  },
  createElementNS() {
    return {};
  },
  importNode() {
    return null;
  },
  location: {
    hash: "",
    host: "",
    hostname: "",
    href: "",
    origin: "",
    pathname: "",
    protocol: "",
    search: "",
  },
};
function He() {
  const e = typeof document != "undefined" ? document : {};
  return lu(e, Fp), e;
}
const B0 = {
  document: Fp,
  navigator: { userAgent: "" },
  location: {
    hash: "",
    host: "",
    hostname: "",
    href: "",
    origin: "",
    pathname: "",
    protocol: "",
    search: "",
  },
  history: { replaceState() {}, pushState() {}, go() {}, back() {} },
  CustomEvent: function () {
    return this;
  },
  addEventListener() {},
  removeEventListener() {},
  getComputedStyle() {
    return {
      getPropertyValue() {
        return "";
      },
    };
  },
  Image() {},
  Date() {},
  screen: {},
  setTimeout() {},
  clearTimeout() {},
  matchMedia() {
    return {};
  },
  requestAnimationFrame(e) {
    return typeof setTimeout == "undefined" ? (e(), null) : setTimeout(e, 0);
  },
  cancelAnimationFrame(e) {
    typeof setTimeout != "undefined" && clearTimeout(e);
  },
};
function Ce() {
  const e = typeof window != "undefined" ? window : {};
  return lu(e, B0), e;
}
function V0(e) {
  const t = e.__proto__;
  Object.defineProperty(e, "__proto__", {
    get() {
      return t;
    },
    set(n) {
      t.__proto__ = n;
    },
  });
}
class Wt extends Array {
  constructor(t) {
    typeof t == "number" ? super(t) : (super(...(t || [])), V0(this));
  }
}
function di(e = []) {
  const t = [];
  return (
    e.forEach((n) => {
      Array.isArray(n) ? t.push(...di(n)) : t.push(n);
    }),
    t
  );
}
function Bp(e, t) {
  return Array.prototype.filter.call(e, t);
}
function H0(e) {
  const t = [];
  for (let n = 0; n < e.length; n += 1) t.indexOf(e[n]) === -1 && t.push(e[n]);
  return t;
}
function U0(e, t) {
  if (typeof e != "string") return [e];
  const n = [],
    r = t.querySelectorAll(e);
  for (let i = 0; i < r.length; i += 1) n.push(r[i]);
  return n;
}
function H(e, t) {
  const n = Ce(),
    r = He();
  let i = [];
  if (!t && e instanceof Wt) return e;
  if (!e) return new Wt(i);
  if (typeof e == "string") {
    const o = e.trim();
    if (o.indexOf("<") >= 0 && o.indexOf(">") >= 0) {
      let l = "div";
      o.indexOf("<li") === 0 && (l = "ul"),
        o.indexOf("<tr") === 0 && (l = "tbody"),
        (o.indexOf("<td") === 0 || o.indexOf("<th") === 0) && (l = "tr"),
        o.indexOf("<tbody") === 0 && (l = "table"),
        o.indexOf("<option") === 0 && (l = "select");
      const a = r.createElement(l);
      a.innerHTML = o;
      for (let s = 0; s < a.childNodes.length; s += 1) i.push(a.childNodes[s]);
    } else i = U0(e.trim(), t || r);
  } else if (e.nodeType || e === n || e === r) i.push(e);
  else if (Array.isArray(e)) {
    if (e instanceof Wt) return e;
    i = e;
  }
  return new Wt(H0(i));
}
H.fn = Wt.prototype;
function W0(...e) {
  const t = di(e.map((n) => n.split(" ")));
  return (
    this.forEach((n) => {
      n.classList.add(...t);
    }),
    this
  );
}
function G0(...e) {
  const t = di(e.map((n) => n.split(" ")));
  return (
    this.forEach((n) => {
      n.classList.remove(...t);
    }),
    this
  );
}
function Y0(...e) {
  const t = di(e.map((n) => n.split(" ")));
  this.forEach((n) => {
    t.forEach((r) => {
      n.classList.toggle(r);
    });
  });
}
function X0(...e) {
  const t = di(e.map((n) => n.split(" ")));
  return (
    Bp(this, (n) => t.filter((r) => n.classList.contains(r)).length > 0)
      .length > 0
  );
}
function Q0(e, t) {
  if (arguments.length === 1 && typeof e == "string")
    return this[0] ? this[0].getAttribute(e) : void 0;
  for (let n = 0; n < this.length; n += 1)
    if (arguments.length === 2) this[n].setAttribute(e, t);
    else for (const r in e) (this[n][r] = e[r]), this[n].setAttribute(r, e[r]);
  return this;
}
function K0(e) {
  for (let t = 0; t < this.length; t += 1) this[t].removeAttribute(e);
  return this;
}
function Z0(e) {
  for (let t = 0; t < this.length; t += 1) this[t].style.transform = e;
  return this;
}
function q0(e) {
  for (let t = 0; t < this.length; t += 1)
    this[t].style.transitionDuration = typeof e != "string" ? `${e}ms` : e;
  return this;
}
function J0(...e) {
  let [t, n, r, i] = e;
  typeof e[1] == "function" && (([t, r, i] = e), (n = void 0)), i || (i = !1);
  function o(u) {
    const c = u.target;
    if (!c) return;
    const f = u.target.dom7EventData || [];
    if ((f.indexOf(u) < 0 && f.unshift(u), H(c).is(n))) r.apply(c, f);
    else {
      const d = H(c).parents();
      for (let v = 0; v < d.length; v += 1) H(d[v]).is(n) && r.apply(d[v], f);
    }
  }
  function l(u) {
    const c = u && u.target ? u.target.dom7EventData || [] : [];
    c.indexOf(u) < 0 && c.unshift(u), r.apply(this, c);
  }
  const a = t.split(" ");
  let s;
  for (let u = 0; u < this.length; u += 1) {
    const c = this[u];
    if (n)
      for (s = 0; s < a.length; s += 1) {
        const f = a[s];
        c.dom7LiveListeners || (c.dom7LiveListeners = {}),
          c.dom7LiveListeners[f] || (c.dom7LiveListeners[f] = []),
          c.dom7LiveListeners[f].push({ listener: r, proxyListener: o }),
          c.addEventListener(f, o, i);
      }
    else
      for (s = 0; s < a.length; s += 1) {
        const f = a[s];
        c.dom7Listeners || (c.dom7Listeners = {}),
          c.dom7Listeners[f] || (c.dom7Listeners[f] = []),
          c.dom7Listeners[f].push({ listener: r, proxyListener: l }),
          c.addEventListener(f, l, i);
      }
  }
  return this;
}
function e1(...e) {
  let [t, n, r, i] = e;
  typeof e[1] == "function" && (([t, r, i] = e), (n = void 0)), i || (i = !1);
  const o = t.split(" ");
  for (let l = 0; l < o.length; l += 1) {
    const a = o[l];
    for (let s = 0; s < this.length; s += 1) {
      const u = this[s];
      let c;
      if (
        (!n && u.dom7Listeners
          ? (c = u.dom7Listeners[a])
          : n && u.dom7LiveListeners && (c = u.dom7LiveListeners[a]),
        c && c.length)
      )
        for (let f = c.length - 1; f >= 0; f -= 1) {
          const d = c[f];
          (r && d.listener === r) ||
          (r &&
            d.listener &&
            d.listener.dom7proxy &&
            d.listener.dom7proxy === r)
            ? (u.removeEventListener(a, d.proxyListener, i), c.splice(f, 1))
            : r ||
              (u.removeEventListener(a, d.proxyListener, i), c.splice(f, 1));
        }
    }
  }
  return this;
}
function t1(...e) {
  const t = Ce(),
    n = e[0].split(" "),
    r = e[1];
  for (let i = 0; i < n.length; i += 1) {
    const o = n[i];
    for (let l = 0; l < this.length; l += 1) {
      const a = this[l];
      if (t.CustomEvent) {
        const s = new t.CustomEvent(o, {
          detail: r,
          bubbles: !0,
          cancelable: !0,
        });
        (a.dom7EventData = e.filter((u, c) => c > 0)),
          a.dispatchEvent(s),
          (a.dom7EventData = []),
          delete a.dom7EventData;
      }
    }
  }
  return this;
}
function n1(e) {
  const t = this;
  function n(r) {
    r.target === this && (e.call(this, r), t.off("transitionend", n));
  }
  return e && t.on("transitionend", n), this;
}
function r1(e) {
  if (this.length > 0) {
    if (e) {
      const t = this.styles();
      return (
        this[0].offsetWidth +
        parseFloat(t.getPropertyValue("margin-right")) +
        parseFloat(t.getPropertyValue("margin-left"))
      );
    }
    return this[0].offsetWidth;
  }
  return null;
}
function i1(e) {
  if (this.length > 0) {
    if (e) {
      const t = this.styles();
      return (
        this[0].offsetHeight +
        parseFloat(t.getPropertyValue("margin-top")) +
        parseFloat(t.getPropertyValue("margin-bottom"))
      );
    }
    return this[0].offsetHeight;
  }
  return null;
}
function o1() {
  if (this.length > 0) {
    const e = Ce(),
      t = He(),
      n = this[0],
      r = n.getBoundingClientRect(),
      i = t.body,
      o = n.clientTop || i.clientTop || 0,
      l = n.clientLeft || i.clientLeft || 0,
      a = n === e ? e.scrollY : n.scrollTop,
      s = n === e ? e.scrollX : n.scrollLeft;
    return { top: r.top + a - o, left: r.left + s - l };
  }
  return null;
}
function l1() {
  const e = Ce();
  return this[0] ? e.getComputedStyle(this[0], null) : {};
}
function s1(e, t) {
  const n = Ce();
  let r;
  if (arguments.length === 1)
    if (typeof e == "string") {
      if (this[0]) return n.getComputedStyle(this[0], null).getPropertyValue(e);
    } else {
      for (r = 0; r < this.length; r += 1)
        for (const i in e) this[r].style[i] = e[i];
      return this;
    }
  if (arguments.length === 2 && typeof e == "string") {
    for (r = 0; r < this.length; r += 1) this[r].style[e] = t;
    return this;
  }
  return this;
}
function a1(e) {
  return e
    ? (this.forEach((t, n) => {
        e.apply(t, [t, n]);
      }),
      this)
    : this;
}
function u1(e) {
  const t = Bp(this, e);
  return H(t);
}
function c1(e) {
  if (typeof e == "undefined") return this[0] ? this[0].innerHTML : null;
  for (let t = 0; t < this.length; t += 1) this[t].innerHTML = e;
  return this;
}
function f1(e) {
  if (typeof e == "undefined")
    return this[0] ? this[0].textContent.trim() : null;
  for (let t = 0; t < this.length; t += 1) this[t].textContent = e;
  return this;
}
function d1(e) {
  const t = Ce(),
    n = He(),
    r = this[0];
  let i, o;
  if (!r || typeof e == "undefined") return !1;
  if (typeof e == "string") {
    if (r.matches) return r.matches(e);
    if (r.webkitMatchesSelector) return r.webkitMatchesSelector(e);
    if (r.msMatchesSelector) return r.msMatchesSelector(e);
    for (i = H(e), o = 0; o < i.length; o += 1) if (i[o] === r) return !0;
    return !1;
  }
  if (e === n) return r === n;
  if (e === t) return r === t;
  if (e.nodeType || e instanceof Wt) {
    for (i = e.nodeType ? [e] : e, o = 0; o < i.length; o += 1)
      if (i[o] === r) return !0;
    return !1;
  }
  return !1;
}
function p1() {
  let e = this[0],
    t;
  if (e) {
    for (t = 0; (e = e.previousSibling) !== null; )
      e.nodeType === 1 && (t += 1);
    return t;
  }
}
function h1(e) {
  if (typeof e == "undefined") return this;
  const t = this.length;
  if (e > t - 1) return H([]);
  if (e < 0) {
    const n = t + e;
    return n < 0 ? H([]) : H([this[n]]);
  }
  return H([this[e]]);
}
function m1(...e) {
  let t;
  const n = He();
  for (let r = 0; r < e.length; r += 1) {
    t = e[r];
    for (let i = 0; i < this.length; i += 1)
      if (typeof t == "string") {
        const o = n.createElement("div");
        for (o.innerHTML = t; o.firstChild; ) this[i].appendChild(o.firstChild);
      } else if (t instanceof Wt)
        for (let o = 0; o < t.length; o += 1) this[i].appendChild(t[o]);
      else this[i].appendChild(t);
  }
  return this;
}
function v1(e) {
  const t = He();
  let n, r;
  for (n = 0; n < this.length; n += 1)
    if (typeof e == "string") {
      const i = t.createElement("div");
      for (i.innerHTML = e, r = i.childNodes.length - 1; r >= 0; r -= 1)
        this[n].insertBefore(i.childNodes[r], this[n].childNodes[0]);
    } else if (e instanceof Wt)
      for (r = 0; r < e.length; r += 1)
        this[n].insertBefore(e[r], this[n].childNodes[0]);
    else this[n].insertBefore(e, this[n].childNodes[0]);
  return this;
}
function g1(e) {
  return this.length > 0
    ? e
      ? this[0].nextElementSibling && H(this[0].nextElementSibling).is(e)
        ? H([this[0].nextElementSibling])
        : H([])
      : this[0].nextElementSibling
      ? H([this[0].nextElementSibling])
      : H([])
    : H([]);
}
function y1(e) {
  const t = [];
  let n = this[0];
  if (!n) return H([]);
  for (; n.nextElementSibling; ) {
    const r = n.nextElementSibling;
    e ? H(r).is(e) && t.push(r) : t.push(r), (n = r);
  }
  return H(t);
}
function S1(e) {
  if (this.length > 0) {
    const t = this[0];
    return e
      ? t.previousElementSibling && H(t.previousElementSibling).is(e)
        ? H([t.previousElementSibling])
        : H([])
      : t.previousElementSibling
      ? H([t.previousElementSibling])
      : H([]);
  }
  return H([]);
}
function w1(e) {
  const t = [];
  let n = this[0];
  if (!n) return H([]);
  for (; n.previousElementSibling; ) {
    const r = n.previousElementSibling;
    e ? H(r).is(e) && t.push(r) : t.push(r), (n = r);
  }
  return H(t);
}
function x1(e) {
  const t = [];
  for (let n = 0; n < this.length; n += 1)
    this[n].parentNode !== null &&
      (e
        ? H(this[n].parentNode).is(e) && t.push(this[n].parentNode)
        : t.push(this[n].parentNode));
  return H(t);
}
function C1(e) {
  const t = [];
  for (let n = 0; n < this.length; n += 1) {
    let r = this[n].parentNode;
    for (; r; ) e ? H(r).is(e) && t.push(r) : t.push(r), (r = r.parentNode);
  }
  return H(t);
}
function E1(e) {
  let t = this;
  return typeof e == "undefined"
    ? H([])
    : (t.is(e) || (t = t.parents(e).eq(0)), t);
}
function T1(e) {
  const t = [];
  for (let n = 0; n < this.length; n += 1) {
    const r = this[n].querySelectorAll(e);
    for (let i = 0; i < r.length; i += 1) t.push(r[i]);
  }
  return H(t);
}
function k1(e) {
  const t = [];
  for (let n = 0; n < this.length; n += 1) {
    const r = this[n].children;
    for (let i = 0; i < r.length; i += 1) (!e || H(r[i]).is(e)) && t.push(r[i]);
  }
  return H(t);
}
function P1() {
  for (let e = 0; e < this.length; e += 1)
    this[e].parentNode && this[e].parentNode.removeChild(this[e]);
  return this;
}
const Vc = {
  addClass: W0,
  removeClass: G0,
  hasClass: X0,
  toggleClass: Y0,
  attr: Q0,
  removeAttr: K0,
  transform: Z0,
  transition: q0,
  on: J0,
  off: e1,
  trigger: t1,
  transitionEnd: n1,
  outerWidth: r1,
  outerHeight: i1,
  styles: l1,
  offset: o1,
  css: s1,
  each: a1,
  html: c1,
  text: f1,
  is: d1,
  index: p1,
  eq: h1,
  append: m1,
  prepend: v1,
  next: g1,
  nextAll: y1,
  prev: S1,
  prevAll: w1,
  parent: x1,
  parents: C1,
  closest: E1,
  find: T1,
  children: k1,
  filter: u1,
  remove: P1,
};
Object.keys(Vc).forEach((e) => {
  Object.defineProperty(H.fn, e, { value: Vc[e], writable: !0 });
});
function $1(e) {
  const t = e;
  Object.keys(t).forEach((n) => {
    try {
      t[n] = null;
    } catch {}
    try {
      delete t[n];
    } catch {}
  });
}
function ar(e, t = 0) {
  return setTimeout(e, t);
}
function qe() {
  return Date.now();
}
function _1(e) {
  const t = Ce();
  let n;
  return (
    t.getComputedStyle && (n = t.getComputedStyle(e, null)),
    !n && e.currentStyle && (n = e.currentStyle),
    n || (n = e.style),
    n
  );
}
function L1(e, t = "x") {
  const n = Ce();
  let r, i, o;
  const l = _1(e);
  return (
    n.WebKitCSSMatrix
      ? ((i = l.transform || l.webkitTransform),
        i.split(",").length > 6 &&
          (i = i
            .split(", ")
            .map((a) => a.replace(",", "."))
            .join(", ")),
        (o = new n.WebKitCSSMatrix(i === "none" ? "" : i)))
      : ((o =
          l.MozTransform ||
          l.OTransform ||
          l.MsTransform ||
          l.msTransform ||
          l.transform ||
          l
            .getPropertyValue("transform")
            .replace("translate(", "matrix(1, 0, 0, 1,")),
        (r = o.toString().split(","))),
    t === "x" &&
      (n.WebKitCSSMatrix
        ? (i = o.m41)
        : r.length === 16
        ? (i = parseFloat(r[12]))
        : (i = parseFloat(r[4]))),
    t === "y" &&
      (n.WebKitCSSMatrix
        ? (i = o.m42)
        : r.length === 16
        ? (i = parseFloat(r[13]))
        : (i = parseFloat(r[5]))),
    i || 0
  );
}
function zi(e) {
  return (
    typeof e == "object" &&
    e !== null &&
    e.constructor &&
    Object.prototype.toString.call(e).slice(8, -1) === "Object"
  );
}
function O1(e) {
  return typeof window != "undefined" &&
    typeof window.HTMLElement != "undefined"
    ? e instanceof HTMLElement
    : e && (e.nodeType === 1 || e.nodeType === 11);
}
function Ze(...e) {
  const t = Object(e[0]),
    n = ["__proto__", "constructor", "prototype"];
  for (let r = 1; r < e.length; r += 1) {
    const i = e[r];
    if (i != null && !O1(i)) {
      const o = Object.keys(Object(i)).filter((l) => n.indexOf(l) < 0);
      for (let l = 0, a = o.length; l < a; l += 1) {
        const s = o[l],
          u = Object.getOwnPropertyDescriptor(i, s);
        u !== void 0 &&
          u.enumerable &&
          (zi(t[s]) && zi(i[s])
            ? i[s].__swiper__
              ? (t[s] = i[s])
              : Ze(t[s], i[s])
            : !zi(t[s]) && zi(i[s])
            ? ((t[s] = {}), i[s].__swiper__ ? (t[s] = i[s]) : Ze(t[s], i[s]))
            : (t[s] = i[s]));
      }
    }
  }
  return t;
}
function Ri(e, t, n) {
  e.style.setProperty(t, n);
}
function Vp({ swiper: e, targetPosition: t, side: n }) {
  const r = Ce(),
    i = -e.translate;
  let o = null,
    l;
  const a = e.params.speed;
  (e.wrapperEl.style.scrollSnapType = "none"),
    r.cancelAnimationFrame(e.cssModeFrameID);
  const s = t > i ? "next" : "prev",
    u = (f, d) => (s === "next" && f >= d) || (s === "prev" && f <= d),
    c = () => {
      (l = new Date().getTime()), o === null && (o = l);
      const f = Math.max(Math.min((l - o) / a, 1), 0),
        d = 0.5 - Math.cos(f * Math.PI) / 2;
      let v = i + d * (t - i);
      if ((u(v, t) && (v = t), e.wrapperEl.scrollTo({ [n]: v }), u(v, t))) {
        (e.wrapperEl.style.overflow = "hidden"),
          (e.wrapperEl.style.scrollSnapType = ""),
          setTimeout(() => {
            (e.wrapperEl.style.overflow = ""), e.wrapperEl.scrollTo({ [n]: v });
          }),
          r.cancelAnimationFrame(e.cssModeFrameID);
        return;
      }
      e.cssModeFrameID = r.requestAnimationFrame(c);
    };
  c();
}
let jl;
function M1() {
  const e = Ce(),
    t = He();
  return {
    smoothScroll:
      t.documentElement && "scrollBehavior" in t.documentElement.style,
    touch: !!(
      "ontouchstart" in e ||
      (e.DocumentTouch && t instanceof e.DocumentTouch)
    ),
    passiveListener: (function () {
      let r = !1;
      try {
        const i = Object.defineProperty({}, "passive", {
          get() {
            r = !0;
          },
        });
        e.addEventListener("testPassiveListener", null, i);
      } catch {}
      return r;
    })(),
    gestures: (function () {
      return "ongesturestart" in e;
    })(),
  };
}
function Hp() {
  return jl || (jl = M1()), jl;
}
let Fl;
function N1({ userAgent: e } = {}) {
  const t = Hp(),
    n = Ce(),
    r = n.navigator.platform,
    i = e || n.navigator.userAgent,
    o = { ios: !1, android: !1 },
    l = n.screen.width,
    a = n.screen.height,
    s = i.match(/(Android);?[\s\/]+([\d.]+)?/);
  let u = i.match(/(iPad).*OS\s([\d_]+)/);
  const c = i.match(/(iPod)(.*OS\s([\d_]+))?/),
    f = !u && i.match(/(iPhone\sOS|iOS)\s([\d_]+)/),
    d = r === "Win32";
  let v = r === "MacIntel";
  const g = [
    "1024x1366",
    "1366x1024",
    "834x1194",
    "1194x834",
    "834x1112",
    "1112x834",
    "768x1024",
    "1024x768",
    "820x1180",
    "1180x820",
    "810x1080",
    "1080x810",
  ];
  return (
    !u &&
      v &&
      t.touch &&
      g.indexOf(`${l}x${a}`) >= 0 &&
      ((u = i.match(/(Version)\/([\d.]+)/)),
      u || (u = [0, 1, "13_0_0"]),
      (v = !1)),
    s && !d && ((o.os = "android"), (o.android = !0)),
    (u || f || c) && ((o.os = "ios"), (o.ios = !0)),
    o
  );
}
function A1(e = {}) {
  return Fl || (Fl = N1(e)), Fl;
}
let Bl;
function z1() {
  const e = Ce();
  function t() {
    const n = e.navigator.userAgent.toLowerCase();
    return (
      n.indexOf("safari") >= 0 &&
      n.indexOf("chrome") < 0 &&
      n.indexOf("android") < 0
    );
  }
  return {
    isSafari: t(),
    isWebView: /(iPhone|iPod|iPad).*AppleWebKit(?!.*Safari)/i.test(
      e.navigator.userAgent
    ),
  };
}
function R1() {
  return Bl || (Bl = z1()), Bl;
}
function I1({ swiper: e, on: t, emit: n }) {
  const r = Ce();
  let i = null,
    o = null;
  const l = () => {
      !e || e.destroyed || !e.initialized || (n("beforeResize"), n("resize"));
    },
    a = () => {
      !e ||
        e.destroyed ||
        !e.initialized ||
        ((i = new ResizeObserver((c) => {
          o = r.requestAnimationFrame(() => {
            const { width: f, height: d } = e;
            let v = f,
              g = d;
            c.forEach(({ contentBoxSize: y, contentRect: x, target: h }) => {
              (h && h !== e.el) ||
                ((v = x ? x.width : (y[0] || y).inlineSize),
                (g = x ? x.height : (y[0] || y).blockSize));
            }),
              (v !== f || g !== d) && l();
          });
        })),
        i.observe(e.el));
    },
    s = () => {
      o && r.cancelAnimationFrame(o),
        i && i.unobserve && e.el && (i.unobserve(e.el), (i = null));
    },
    u = () => {
      !e || e.destroyed || !e.initialized || n("orientationchange");
    };
  t("init", () => {
    if (e.params.resizeObserver && typeof r.ResizeObserver != "undefined") {
      a();
      return;
    }
    r.addEventListener("resize", l), r.addEventListener("orientationchange", u);
  }),
    t("destroy", () => {
      s(),
        r.removeEventListener("resize", l),
        r.removeEventListener("orientationchange", u);
    });
}
function b1({ swiper: e, extendParams: t, on: n, emit: r }) {
  const i = [],
    o = Ce(),
    l = (u, c = {}) => {
      const f = o.MutationObserver || o.WebkitMutationObserver,
        d = new f((v) => {
          if (v.length === 1) {
            r("observerUpdate", v[0]);
            return;
          }
          const g = function () {
            r("observerUpdate", v[0]);
          };
          o.requestAnimationFrame
            ? o.requestAnimationFrame(g)
            : o.setTimeout(g, 0);
        });
      d.observe(u, {
        attributes: typeof c.attributes == "undefined" ? !0 : c.attributes,
        childList: typeof c.childList == "undefined" ? !0 : c.childList,
        characterData:
          typeof c.characterData == "undefined" ? !0 : c.characterData,
      }),
        i.push(d);
    },
    a = () => {
      if (!!e.params.observer) {
        if (e.params.observeParents) {
          const u = e.$el.parents();
          for (let c = 0; c < u.length; c += 1) l(u[c]);
        }
        l(e.$el[0], { childList: e.params.observeSlideChildren }),
          l(e.$wrapperEl[0], { attributes: !1 });
      }
    },
    s = () => {
      i.forEach((u) => {
        u.disconnect();
      }),
        i.splice(0, i.length);
    };
  t({ observer: !1, observeParents: !1, observeSlideChildren: !1 }),
    n("init", a),
    n("destroy", s);
}
var D1 = {
  on(e, t, n) {
    const r = this;
    if (!r.eventsListeners || r.destroyed || typeof t != "function") return r;
    const i = n ? "unshift" : "push";
    return (
      e.split(" ").forEach((o) => {
        r.eventsListeners[o] || (r.eventsListeners[o] = []),
          r.eventsListeners[o][i](t);
      }),
      r
    );
  },
  once(e, t, n) {
    const r = this;
    if (!r.eventsListeners || r.destroyed || typeof t != "function") return r;
    function i(...o) {
      r.off(e, i), i.__emitterProxy && delete i.__emitterProxy, t.apply(r, o);
    }
    return (i.__emitterProxy = t), r.on(e, i, n);
  },
  onAny(e, t) {
    const n = this;
    if (!n.eventsListeners || n.destroyed || typeof e != "function") return n;
    const r = t ? "unshift" : "push";
    return n.eventsAnyListeners.indexOf(e) < 0 && n.eventsAnyListeners[r](e), n;
  },
  offAny(e) {
    const t = this;
    if (!t.eventsListeners || t.destroyed || !t.eventsAnyListeners) return t;
    const n = t.eventsAnyListeners.indexOf(e);
    return n >= 0 && t.eventsAnyListeners.splice(n, 1), t;
  },
  off(e, t) {
    const n = this;
    return (
      !n.eventsListeners ||
        n.destroyed ||
        !n.eventsListeners ||
        e.split(" ").forEach((r) => {
          typeof t == "undefined"
            ? (n.eventsListeners[r] = [])
            : n.eventsListeners[r] &&
              n.eventsListeners[r].forEach((i, o) => {
                (i === t || (i.__emitterProxy && i.__emitterProxy === t)) &&
                  n.eventsListeners[r].splice(o, 1);
              });
        }),
      n
    );
  },
  emit(...e) {
    const t = this;
    if (!t.eventsListeners || t.destroyed || !t.eventsListeners) return t;
    let n, r, i;
    return (
      typeof e[0] == "string" || Array.isArray(e[0])
        ? ((n = e[0]), (r = e.slice(1, e.length)), (i = t))
        : ((n = e[0].events), (r = e[0].data), (i = e[0].context || t)),
      r.unshift(i),
      (Array.isArray(n) ? n : n.split(" ")).forEach((l) => {
        t.eventsAnyListeners &&
          t.eventsAnyListeners.length &&
          t.eventsAnyListeners.forEach((a) => {
            a.apply(i, [l, ...r]);
          }),
          t.eventsListeners &&
            t.eventsListeners[l] &&
            t.eventsListeners[l].forEach((a) => {
              a.apply(i, r);
            });
      }),
      t
    );
  },
};
function j1() {
  const e = this;
  let t, n;
  const r = e.$el;
  typeof e.params.width != "undefined" && e.params.width !== null
    ? (t = e.params.width)
    : (t = r[0].clientWidth),
    typeof e.params.height != "undefined" && e.params.height !== null
      ? (n = e.params.height)
      : (n = r[0].clientHeight),
    !((t === 0 && e.isHorizontal()) || (n === 0 && e.isVertical())) &&
      ((t =
        t -
        parseInt(r.css("padding-left") || 0, 10) -
        parseInt(r.css("padding-right") || 0, 10)),
      (n =
        n -
        parseInt(r.css("padding-top") || 0, 10) -
        parseInt(r.css("padding-bottom") || 0, 10)),
      Number.isNaN(t) && (t = 0),
      Number.isNaN(n) && (n = 0),
      Object.assign(e, {
        width: t,
        height: n,
        size: e.isHorizontal() ? t : n,
      }));
}
function F1() {
  const e = this;
  function t(L) {
    return e.isHorizontal()
      ? L
      : {
          width: "height",
          "margin-top": "margin-left",
          "margin-bottom ": "margin-right",
          "margin-left": "margin-top",
          "margin-right": "margin-bottom",
          "padding-left": "padding-top",
          "padding-right": "padding-bottom",
          marginRight: "marginBottom",
        }[L];
  }
  function n(L, T) {
    return parseFloat(L.getPropertyValue(t(T)) || 0);
  }
  const r = e.params,
    { $wrapperEl: i, size: o, rtlTranslate: l, wrongRTL: a } = e,
    s = e.virtual && r.virtual.enabled,
    u = s ? e.virtual.slides.length : e.slides.length,
    c = i.children(`.${e.params.slideClass}`),
    f = s ? e.virtual.slides.length : c.length;
  let d = [];
  const v = [],
    g = [];
  let y = r.slidesOffsetBefore;
  typeof y == "function" && (y = r.slidesOffsetBefore.call(e));
  let x = r.slidesOffsetAfter;
  typeof x == "function" && (x = r.slidesOffsetAfter.call(e));
  const h = e.snapGrid.length,
    p = e.slidesGrid.length;
  let m = r.spaceBetween,
    S = -y,
    w = 0,
    P = 0;
  if (typeof o == "undefined") return;
  typeof m == "string" &&
    m.indexOf("%") >= 0 &&
    (m = (parseFloat(m.replace("%", "")) / 100) * o),
    (e.virtualSize = -m),
    l
      ? c.css({ marginLeft: "", marginBottom: "", marginTop: "" })
      : c.css({ marginRight: "", marginBottom: "", marginTop: "" }),
    r.centeredSlides &&
      r.cssMode &&
      (Ri(e.wrapperEl, "--swiper-centered-offset-before", ""),
      Ri(e.wrapperEl, "--swiper-centered-offset-after", ""));
  const E = r.grid && r.grid.rows > 1 && e.grid;
  E && e.grid.initSlides(f);
  let k;
  const D =
    r.slidesPerView === "auto" &&
    r.breakpoints &&
    Object.keys(r.breakpoints).filter(
      (L) => typeof r.breakpoints[L].slidesPerView != "undefined"
    ).length > 0;
  for (let L = 0; L < f; L += 1) {
    k = 0;
    const T = c.eq(L);
    if ((E && e.grid.updateSlide(L, T, f, t), T.css("display") !== "none")) {
      if (r.slidesPerView === "auto") {
        D && (c[L].style[t("width")] = "");
        const N = getComputedStyle(T[0]),
          j = T[0].style.transform,
          U = T[0].style.webkitTransform;
        if (
          (j && (T[0].style.transform = "none"),
          U && (T[0].style.webkitTransform = "none"),
          r.roundLengths)
        )
          k = e.isHorizontal() ? T.outerWidth(!0) : T.outerHeight(!0);
        else {
          const B = n(N, "width"),
            Z = n(N, "padding-left"),
            q = n(N, "padding-right"),
            $ = n(N, "margin-left"),
            O = n(N, "margin-right"),
            M = N.getPropertyValue("box-sizing");
          if (M && M === "border-box") k = B + $ + O;
          else {
            const { clientWidth: F, offsetWidth: _ } = T[0];
            k = B + Z + q + $ + O + (_ - F);
          }
        }
        j && (T[0].style.transform = j),
          U && (T[0].style.webkitTransform = U),
          r.roundLengths && (k = Math.floor(k));
      } else
        (k = (o - (r.slidesPerView - 1) * m) / r.slidesPerView),
          r.roundLengths && (k = Math.floor(k)),
          c[L] && (c[L].style[t("width")] = `${k}px`);
      c[L] && (c[L].swiperSlideSize = k),
        g.push(k),
        r.centeredSlides
          ? ((S = S + k / 2 + w / 2 + m),
            w === 0 && L !== 0 && (S = S - o / 2 - m),
            L === 0 && (S = S - o / 2 - m),
            Math.abs(S) < 1 / 1e3 && (S = 0),
            r.roundLengths && (S = Math.floor(S)),
            P % r.slidesPerGroup === 0 && d.push(S),
            v.push(S))
          : (r.roundLengths && (S = Math.floor(S)),
            (P - Math.min(e.params.slidesPerGroupSkip, P)) %
              e.params.slidesPerGroup ===
              0 && d.push(S),
            v.push(S),
            (S = S + k + m)),
        (e.virtualSize += k + m),
        (w = k),
        (P += 1);
    }
  }
  if (
    ((e.virtualSize = Math.max(e.virtualSize, o) + x),
    l &&
      a &&
      (r.effect === "slide" || r.effect === "coverflow") &&
      i.css({ width: `${e.virtualSize + r.spaceBetween}px` }),
    r.setWrapperSize &&
      i.css({ [t("width")]: `${e.virtualSize + r.spaceBetween}px` }),
    E && e.grid.updateWrapperSize(k, d, t),
    !r.centeredSlides)
  ) {
    const L = [];
    for (let T = 0; T < d.length; T += 1) {
      let N = d[T];
      r.roundLengths && (N = Math.floor(N)),
        d[T] <= e.virtualSize - o && L.push(N);
    }
    (d = L),
      Math.floor(e.virtualSize - o) - Math.floor(d[d.length - 1]) > 1 &&
        d.push(e.virtualSize - o);
  }
  if ((d.length === 0 && (d = [0]), r.spaceBetween !== 0)) {
    const L = e.isHorizontal() && l ? "marginLeft" : t("marginRight");
    c.filter((T, N) => (r.cssMode ? N !== c.length - 1 : !0)).css({
      [L]: `${m}px`,
    });
  }
  if (r.centeredSlides && r.centeredSlidesBounds) {
    let L = 0;
    g.forEach((N) => {
      L += N + (r.spaceBetween ? r.spaceBetween : 0);
    }),
      (L -= r.spaceBetween);
    const T = L - o;
    d = d.map((N) => (N < 0 ? -y : N > T ? T + x : N));
  }
  if (r.centerInsufficientSlides) {
    let L = 0;
    if (
      (g.forEach((T) => {
        L += T + (r.spaceBetween ? r.spaceBetween : 0);
      }),
      (L -= r.spaceBetween),
      L < o)
    ) {
      const T = (o - L) / 2;
      d.forEach((N, j) => {
        d[j] = N - T;
      }),
        v.forEach((N, j) => {
          v[j] = N + T;
        });
    }
  }
  if (
    (Object.assign(e, {
      slides: c,
      snapGrid: d,
      slidesGrid: v,
      slidesSizesGrid: g,
    }),
    r.centeredSlides && r.cssMode && !r.centeredSlidesBounds)
  ) {
    Ri(e.wrapperEl, "--swiper-centered-offset-before", `${-d[0]}px`),
      Ri(
        e.wrapperEl,
        "--swiper-centered-offset-after",
        `${e.size / 2 - g[g.length - 1] / 2}px`
      );
    const L = -e.snapGrid[0],
      T = -e.slidesGrid[0];
    (e.snapGrid = e.snapGrid.map((N) => N + L)),
      (e.slidesGrid = e.slidesGrid.map((N) => N + T));
  }
  if (
    (f !== u && e.emit("slidesLengthChange"),
    d.length !== h &&
      (e.params.watchOverflow && e.checkOverflow(),
      e.emit("snapGridLengthChange")),
    v.length !== p && e.emit("slidesGridLengthChange"),
    r.watchSlidesProgress && e.updateSlidesOffset(),
    !s && !r.cssMode && (r.effect === "slide" || r.effect === "fade"))
  ) {
    const L = `${r.containerModifierClass}backface-hidden`,
      T = e.$el.hasClass(L);
    f <= r.maxBackfaceHiddenSlides
      ? T || e.$el.addClass(L)
      : T && e.$el.removeClass(L);
  }
}
function B1(e) {
  const t = this,
    n = [],
    r = t.virtual && t.params.virtual.enabled;
  let i = 0,
    o;
  typeof e == "number"
    ? t.setTransition(e)
    : e === !0 && t.setTransition(t.params.speed);
  const l = (a) =>
    r
      ? t.slides.filter(
          (s) => parseInt(s.getAttribute("data-swiper-slide-index"), 10) === a
        )[0]
      : t.slides.eq(a)[0];
  if (t.params.slidesPerView !== "auto" && t.params.slidesPerView > 1)
    if (t.params.centeredSlides)
      (t.visibleSlides || H([])).each((a) => {
        n.push(a);
      });
    else
      for (o = 0; o < Math.ceil(t.params.slidesPerView); o += 1) {
        const a = t.activeIndex + o;
        if (a > t.slides.length && !r) break;
        n.push(l(a));
      }
  else n.push(l(t.activeIndex));
  for (o = 0; o < n.length; o += 1)
    if (typeof n[o] != "undefined") {
      const a = n[o].offsetHeight;
      i = a > i ? a : i;
    }
  (i || i === 0) && t.$wrapperEl.css("height", `${i}px`);
}
function V1() {
  const e = this,
    t = e.slides;
  for (let n = 0; n < t.length; n += 1)
    t[n].swiperSlideOffset = e.isHorizontal()
      ? t[n].offsetLeft
      : t[n].offsetTop;
}
function H1(e = (this && this.translate) || 0) {
  const t = this,
    n = t.params,
    { slides: r, rtlTranslate: i, snapGrid: o } = t;
  if (r.length === 0) return;
  typeof r[0].swiperSlideOffset == "undefined" && t.updateSlidesOffset();
  let l = -e;
  i && (l = e),
    r.removeClass(n.slideVisibleClass),
    (t.visibleSlidesIndexes = []),
    (t.visibleSlides = []);
  for (let a = 0; a < r.length; a += 1) {
    const s = r[a];
    let u = s.swiperSlideOffset;
    n.cssMode && n.centeredSlides && (u -= r[0].swiperSlideOffset);
    const c =
        (l + (n.centeredSlides ? t.minTranslate() : 0) - u) /
        (s.swiperSlideSize + n.spaceBetween),
      f =
        (l - o[0] + (n.centeredSlides ? t.minTranslate() : 0) - u) /
        (s.swiperSlideSize + n.spaceBetween),
      d = -(l - u),
      v = d + t.slidesSizesGrid[a];
    ((d >= 0 && d < t.size - 1) ||
      (v > 1 && v <= t.size) ||
      (d <= 0 && v >= t.size)) &&
      (t.visibleSlides.push(s),
      t.visibleSlidesIndexes.push(a),
      r.eq(a).addClass(n.slideVisibleClass)),
      (s.progress = i ? -c : c),
      (s.originalProgress = i ? -f : f);
  }
  t.visibleSlides = H(t.visibleSlides);
}
function U1(e) {
  const t = this;
  if (typeof e == "undefined") {
    const u = t.rtlTranslate ? -1 : 1;
    e = (t && t.translate && t.translate * u) || 0;
  }
  const n = t.params,
    r = t.maxTranslate() - t.minTranslate();
  let { progress: i, isBeginning: o, isEnd: l } = t;
  const a = o,
    s = l;
  r === 0
    ? ((i = 0), (o = !0), (l = !0))
    : ((i = (e - t.minTranslate()) / r), (o = i <= 0), (l = i >= 1)),
    Object.assign(t, { progress: i, isBeginning: o, isEnd: l }),
    (n.watchSlidesProgress || (n.centeredSlides && n.autoHeight)) &&
      t.updateSlidesProgress(e),
    o && !a && t.emit("reachBeginning toEdge"),
    l && !s && t.emit("reachEnd toEdge"),
    ((a && !o) || (s && !l)) && t.emit("fromEdge"),
    t.emit("progress", i);
}
function W1() {
  const e = this,
    { slides: t, params: n, $wrapperEl: r, activeIndex: i, realIndex: o } = e,
    l = e.virtual && n.virtual.enabled;
  t.removeClass(
    `${n.slideActiveClass} ${n.slideNextClass} ${n.slidePrevClass} ${n.slideDuplicateActiveClass} ${n.slideDuplicateNextClass} ${n.slideDuplicatePrevClass}`
  );
  let a;
  l
    ? (a = e.$wrapperEl.find(
        `.${n.slideClass}[data-swiper-slide-index="${i}"]`
      ))
    : (a = t.eq(i)),
    a.addClass(n.slideActiveClass),
    n.loop &&
      (a.hasClass(n.slideDuplicateClass)
        ? r
            .children(
              `.${n.slideClass}:not(.${n.slideDuplicateClass})[data-swiper-slide-index="${o}"]`
            )
            .addClass(n.slideDuplicateActiveClass)
        : r
            .children(
              `.${n.slideClass}.${n.slideDuplicateClass}[data-swiper-slide-index="${o}"]`
            )
            .addClass(n.slideDuplicateActiveClass));
  let s = a.nextAll(`.${n.slideClass}`).eq(0).addClass(n.slideNextClass);
  n.loop && s.length === 0 && ((s = t.eq(0)), s.addClass(n.slideNextClass));
  let u = a.prevAll(`.${n.slideClass}`).eq(0).addClass(n.slidePrevClass);
  n.loop && u.length === 0 && ((u = t.eq(-1)), u.addClass(n.slidePrevClass)),
    n.loop &&
      (s.hasClass(n.slideDuplicateClass)
        ? r
            .children(
              `.${n.slideClass}:not(.${
                n.slideDuplicateClass
              })[data-swiper-slide-index="${s.attr(
                "data-swiper-slide-index"
              )}"]`
            )
            .addClass(n.slideDuplicateNextClass)
        : r
            .children(
              `.${n.slideClass}.${
                n.slideDuplicateClass
              }[data-swiper-slide-index="${s.attr("data-swiper-slide-index")}"]`
            )
            .addClass(n.slideDuplicateNextClass),
      u.hasClass(n.slideDuplicateClass)
        ? r
            .children(
              `.${n.slideClass}:not(.${
                n.slideDuplicateClass
              })[data-swiper-slide-index="${u.attr(
                "data-swiper-slide-index"
              )}"]`
            )
            .addClass(n.slideDuplicatePrevClass)
        : r
            .children(
              `.${n.slideClass}.${
                n.slideDuplicateClass
              }[data-swiper-slide-index="${u.attr("data-swiper-slide-index")}"]`
            )
            .addClass(n.slideDuplicatePrevClass)),
    e.emitSlidesClasses();
}
function G1(e) {
  const t = this,
    n = t.rtlTranslate ? t.translate : -t.translate,
    {
      slidesGrid: r,
      snapGrid: i,
      params: o,
      activeIndex: l,
      realIndex: a,
      snapIndex: s,
    } = t;
  let u = e,
    c;
  if (typeof u == "undefined") {
    for (let d = 0; d < r.length; d += 1)
      typeof r[d + 1] != "undefined"
        ? n >= r[d] && n < r[d + 1] - (r[d + 1] - r[d]) / 2
          ? (u = d)
          : n >= r[d] && n < r[d + 1] && (u = d + 1)
        : n >= r[d] && (u = d);
    o.normalizeSlideIndex && (u < 0 || typeof u == "undefined") && (u = 0);
  }
  if (i.indexOf(n) >= 0) c = i.indexOf(n);
  else {
    const d = Math.min(o.slidesPerGroupSkip, u);
    c = d + Math.floor((u - d) / o.slidesPerGroup);
  }
  if ((c >= i.length && (c = i.length - 1), u === l)) {
    c !== s && ((t.snapIndex = c), t.emit("snapIndexChange"));
    return;
  }
  const f = parseInt(t.slides.eq(u).attr("data-swiper-slide-index") || u, 10);
  Object.assign(t, {
    snapIndex: c,
    realIndex: f,
    previousIndex: l,
    activeIndex: u,
  }),
    t.emit("activeIndexChange"),
    t.emit("snapIndexChange"),
    a !== f && t.emit("realIndexChange"),
    (t.initialized || t.params.runCallbacksOnInit) && t.emit("slideChange");
}
function Y1(e) {
  const t = this,
    n = t.params,
    r = H(e).closest(`.${n.slideClass}`)[0];
  let i = !1,
    o;
  if (r) {
    for (let l = 0; l < t.slides.length; l += 1)
      if (t.slides[l] === r) {
        (i = !0), (o = l);
        break;
      }
  }
  if (r && i)
    (t.clickedSlide = r),
      t.virtual && t.params.virtual.enabled
        ? (t.clickedIndex = parseInt(H(r).attr("data-swiper-slide-index"), 10))
        : (t.clickedIndex = o);
  else {
    (t.clickedSlide = void 0), (t.clickedIndex = void 0);
    return;
  }
  n.slideToClickedSlide &&
    t.clickedIndex !== void 0 &&
    t.clickedIndex !== t.activeIndex &&
    t.slideToClickedSlide();
}
var X1 = {
  updateSize: j1,
  updateSlides: F1,
  updateAutoHeight: B1,
  updateSlidesOffset: V1,
  updateSlidesProgress: H1,
  updateProgress: U1,
  updateSlidesClasses: W1,
  updateActiveIndex: G1,
  updateClickedSlide: Y1,
};
function Q1(e = this.isHorizontal() ? "x" : "y") {
  const t = this,
    { params: n, rtlTranslate: r, translate: i, $wrapperEl: o } = t;
  if (n.virtualTranslate) return r ? -i : i;
  if (n.cssMode) return i;
  let l = L1(o[0], e);
  return r && (l = -l), l || 0;
}
function K1(e, t) {
  const n = this,
    {
      rtlTranslate: r,
      params: i,
      $wrapperEl: o,
      wrapperEl: l,
      progress: a,
    } = n;
  let s = 0,
    u = 0;
  const c = 0;
  n.isHorizontal() ? (s = r ? -e : e) : (u = e),
    i.roundLengths && ((s = Math.floor(s)), (u = Math.floor(u))),
    i.cssMode
      ? (l[n.isHorizontal() ? "scrollLeft" : "scrollTop"] = n.isHorizontal()
          ? -s
          : -u)
      : i.virtualTranslate ||
        o.transform(`translate3d(${s}px, ${u}px, ${c}px)`),
    (n.previousTranslate = n.translate),
    (n.translate = n.isHorizontal() ? s : u);
  let f;
  const d = n.maxTranslate() - n.minTranslate();
  d === 0 ? (f = 0) : (f = (e - n.minTranslate()) / d),
    f !== a && n.updateProgress(e),
    n.emit("setTranslate", n.translate, t);
}
function Z1() {
  return -this.snapGrid[0];
}
function q1() {
  return -this.snapGrid[this.snapGrid.length - 1];
}
function J1(e = 0, t = this.params.speed, n = !0, r = !0, i) {
  const o = this,
    { params: l, wrapperEl: a } = o;
  if (o.animating && l.preventInteractionOnTransition) return !1;
  const s = o.minTranslate(),
    u = o.maxTranslate();
  let c;
  if (
    (r && e > s ? (c = s) : r && e < u ? (c = u) : (c = e),
    o.updateProgress(c),
    l.cssMode)
  ) {
    const f = o.isHorizontal();
    if (t === 0) a[f ? "scrollLeft" : "scrollTop"] = -c;
    else {
      if (!o.support.smoothScroll)
        return (
          Vp({ swiper: o, targetPosition: -c, side: f ? "left" : "top" }), !0
        );
      a.scrollTo({ [f ? "left" : "top"]: -c, behavior: "smooth" });
    }
    return !0;
  }
  return (
    t === 0
      ? (o.setTransition(0),
        o.setTranslate(c),
        n && (o.emit("beforeTransitionStart", t, i), o.emit("transitionEnd")))
      : (o.setTransition(t),
        o.setTranslate(c),
        n && (o.emit("beforeTransitionStart", t, i), o.emit("transitionStart")),
        o.animating ||
          ((o.animating = !0),
          o.onTranslateToWrapperTransitionEnd ||
            (o.onTranslateToWrapperTransitionEnd = function (d) {
              !o ||
                o.destroyed ||
                (d.target === this &&
                  (o.$wrapperEl[0].removeEventListener(
                    "transitionend",
                    o.onTranslateToWrapperTransitionEnd
                  ),
                  o.$wrapperEl[0].removeEventListener(
                    "webkitTransitionEnd",
                    o.onTranslateToWrapperTransitionEnd
                  ),
                  (o.onTranslateToWrapperTransitionEnd = null),
                  delete o.onTranslateToWrapperTransitionEnd,
                  n && o.emit("transitionEnd")));
            }),
          o.$wrapperEl[0].addEventListener(
            "transitionend",
            o.onTranslateToWrapperTransitionEnd
          ),
          o.$wrapperEl[0].addEventListener(
            "webkitTransitionEnd",
            o.onTranslateToWrapperTransitionEnd
          ))),
    !0
  );
}
var ey = {
  getTranslate: Q1,
  setTranslate: K1,
  minTranslate: Z1,
  maxTranslate: q1,
  translateTo: J1,
};
function ty(e, t) {
  const n = this;
  n.params.cssMode || n.$wrapperEl.transition(e), n.emit("setTransition", e, t);
}
function Up({ swiper: e, runCallbacks: t, direction: n, step: r }) {
  const { activeIndex: i, previousIndex: o } = e;
  let l = n;
  if (
    (l || (i > o ? (l = "next") : i < o ? (l = "prev") : (l = "reset")),
    e.emit(`transition${r}`),
    t && i !== o)
  ) {
    if (l === "reset") {
      e.emit(`slideResetTransition${r}`);
      return;
    }
    e.emit(`slideChangeTransition${r}`),
      l === "next"
        ? e.emit(`slideNextTransition${r}`)
        : e.emit(`slidePrevTransition${r}`);
  }
}
function ny(e = !0, t) {
  const n = this,
    { params: r } = n;
  r.cssMode ||
    (r.autoHeight && n.updateAutoHeight(),
    Up({ swiper: n, runCallbacks: e, direction: t, step: "Start" }));
}
function ry(e = !0, t) {
  const n = this,
    { params: r } = n;
  (n.animating = !1),
    !r.cssMode &&
      (n.setTransition(0),
      Up({ swiper: n, runCallbacks: e, direction: t, step: "End" }));
}
var iy = { setTransition: ty, transitionStart: ny, transitionEnd: ry };
function oy(e = 0, t = this.params.speed, n = !0, r, i) {
  if (typeof e != "number" && typeof e != "string")
    throw new Error(
      `The 'index' argument cannot have type other than 'number' or 'string'. [${typeof e}] given.`
    );
  if (typeof e == "string") {
    const m = parseInt(e, 10);
    if (!isFinite(m))
      throw new Error(
        `The passed-in 'index' (string) couldn't be converted to 'number'. [${e}] given.`
      );
    e = m;
  }
  const o = this;
  let l = e;
  l < 0 && (l = 0);
  const {
    params: a,
    snapGrid: s,
    slidesGrid: u,
    previousIndex: c,
    activeIndex: f,
    rtlTranslate: d,
    wrapperEl: v,
    enabled: g,
  } = o;
  if ((o.animating && a.preventInteractionOnTransition) || (!g && !r && !i))
    return !1;
  const y = Math.min(o.params.slidesPerGroupSkip, l);
  let x = y + Math.floor((l - y) / o.params.slidesPerGroup);
  x >= s.length && (x = s.length - 1);
  const h = -s[x];
  if (a.normalizeSlideIndex)
    for (let m = 0; m < u.length; m += 1) {
      const S = -Math.floor(h * 100),
        w = Math.floor(u[m] * 100),
        P = Math.floor(u[m + 1] * 100);
      typeof u[m + 1] != "undefined"
        ? S >= w && S < P - (P - w) / 2
          ? (l = m)
          : S >= w && S < P && (l = m + 1)
        : S >= w && (l = m);
    }
  if (
    o.initialized &&
    l !== f &&
    ((!o.allowSlideNext && h < o.translate && h < o.minTranslate()) ||
      (!o.allowSlidePrev &&
        h > o.translate &&
        h > o.maxTranslate() &&
        (f || 0) !== l))
  )
    return !1;
  l !== (c || 0) && n && o.emit("beforeSlideChangeStart"), o.updateProgress(h);
  let p;
  if (
    (l > f ? (p = "next") : l < f ? (p = "prev") : (p = "reset"),
    (d && -h === o.translate) || (!d && h === o.translate))
  )
    return (
      o.updateActiveIndex(l),
      a.autoHeight && o.updateAutoHeight(),
      o.updateSlidesClasses(),
      a.effect !== "slide" && o.setTranslate(h),
      p !== "reset" && (o.transitionStart(n, p), o.transitionEnd(n, p)),
      !1
    );
  if (a.cssMode) {
    const m = o.isHorizontal(),
      S = d ? h : -h;
    if (t === 0) {
      const w = o.virtual && o.params.virtual.enabled;
      w &&
        ((o.wrapperEl.style.scrollSnapType = "none"),
        (o._immediateVirtual = !0)),
        (v[m ? "scrollLeft" : "scrollTop"] = S),
        w &&
          requestAnimationFrame(() => {
            (o.wrapperEl.style.scrollSnapType = ""),
              (o._swiperImmediateVirtual = !1);
          });
    } else {
      if (!o.support.smoothScroll)
        return (
          Vp({ swiper: o, targetPosition: S, side: m ? "left" : "top" }), !0
        );
      v.scrollTo({ [m ? "left" : "top"]: S, behavior: "smooth" });
    }
    return !0;
  }
  return (
    o.setTransition(t),
    o.setTranslate(h),
    o.updateActiveIndex(l),
    o.updateSlidesClasses(),
    o.emit("beforeTransitionStart", t, r),
    o.transitionStart(n, p),
    t === 0
      ? o.transitionEnd(n, p)
      : o.animating ||
        ((o.animating = !0),
        o.onSlideToWrapperTransitionEnd ||
          (o.onSlideToWrapperTransitionEnd = function (S) {
            !o ||
              o.destroyed ||
              (S.target === this &&
                (o.$wrapperEl[0].removeEventListener(
                  "transitionend",
                  o.onSlideToWrapperTransitionEnd
                ),
                o.$wrapperEl[0].removeEventListener(
                  "webkitTransitionEnd",
                  o.onSlideToWrapperTransitionEnd
                ),
                (o.onSlideToWrapperTransitionEnd = null),
                delete o.onSlideToWrapperTransitionEnd,
                o.transitionEnd(n, p)));
          }),
        o.$wrapperEl[0].addEventListener(
          "transitionend",
          o.onSlideToWrapperTransitionEnd
        ),
        o.$wrapperEl[0].addEventListener(
          "webkitTransitionEnd",
          o.onSlideToWrapperTransitionEnd
        )),
    !0
  );
}
function ly(e = 0, t = this.params.speed, n = !0, r) {
  if (typeof e == "string") {
    const l = parseInt(e, 10);
    if (!isFinite(l))
      throw new Error(
        `The passed-in 'index' (string) couldn't be converted to 'number'. [${e}] given.`
      );
    e = l;
  }
  const i = this;
  let o = e;
  return i.params.loop && (o += i.loopedSlides), i.slideTo(o, t, n, r);
}
function sy(e = this.params.speed, t = !0, n) {
  const r = this,
    { animating: i, enabled: o, params: l } = r;
  if (!o) return r;
  let a = l.slidesPerGroup;
  l.slidesPerView === "auto" &&
    l.slidesPerGroup === 1 &&
    l.slidesPerGroupAuto &&
    (a = Math.max(r.slidesPerViewDynamic("current", !0), 1));
  const s = r.activeIndex < l.slidesPerGroupSkip ? 1 : a;
  if (l.loop) {
    if (i && l.loopPreventsSlide) return !1;
    r.loopFix(), (r._clientLeft = r.$wrapperEl[0].clientLeft);
  }
  return l.rewind && r.isEnd
    ? r.slideTo(0, e, t, n)
    : r.slideTo(r.activeIndex + s, e, t, n);
}
function ay(e = this.params.speed, t = !0, n) {
  const r = this,
    {
      params: i,
      animating: o,
      snapGrid: l,
      slidesGrid: a,
      rtlTranslate: s,
      enabled: u,
    } = r;
  if (!u) return r;
  if (i.loop) {
    if (o && i.loopPreventsSlide) return !1;
    r.loopFix(), (r._clientLeft = r.$wrapperEl[0].clientLeft);
  }
  const c = s ? r.translate : -r.translate;
  function f(x) {
    return x < 0 ? -Math.floor(Math.abs(x)) : Math.floor(x);
  }
  const d = f(c),
    v = l.map((x) => f(x));
  let g = l[v.indexOf(d) - 1];
  if (typeof g == "undefined" && i.cssMode) {
    let x;
    l.forEach((h, p) => {
      d >= h && (x = p);
    }),
      typeof x != "undefined" && (g = l[x > 0 ? x - 1 : x]);
  }
  let y = 0;
  if (
    (typeof g != "undefined" &&
      ((y = a.indexOf(g)),
      y < 0 && (y = r.activeIndex - 1),
      i.slidesPerView === "auto" &&
        i.slidesPerGroup === 1 &&
        i.slidesPerGroupAuto &&
        ((y = y - r.slidesPerViewDynamic("previous", !0) + 1),
        (y = Math.max(y, 0)))),
    i.rewind && r.isBeginning)
  ) {
    const x =
      r.params.virtual && r.params.virtual.enabled && r.virtual
        ? r.virtual.slides.length - 1
        : r.slides.length - 1;
    return r.slideTo(x, e, t, n);
  }
  return r.slideTo(y, e, t, n);
}
function uy(e = this.params.speed, t = !0, n) {
  const r = this;
  return r.slideTo(r.activeIndex, e, t, n);
}
function cy(e = this.params.speed, t = !0, n, r = 0.5) {
  const i = this;
  let o = i.activeIndex;
  const l = Math.min(i.params.slidesPerGroupSkip, o),
    a = l + Math.floor((o - l) / i.params.slidesPerGroup),
    s = i.rtlTranslate ? i.translate : -i.translate;
  if (s >= i.snapGrid[a]) {
    const u = i.snapGrid[a],
      c = i.snapGrid[a + 1];
    s - u > (c - u) * r && (o += i.params.slidesPerGroup);
  } else {
    const u = i.snapGrid[a - 1],
      c = i.snapGrid[a];
    s - u <= (c - u) * r && (o -= i.params.slidesPerGroup);
  }
  return (
    (o = Math.max(o, 0)),
    (o = Math.min(o, i.slidesGrid.length - 1)),
    i.slideTo(o, e, t, n)
  );
}
function fy() {
  const e = this,
    { params: t, $wrapperEl: n } = e,
    r = t.slidesPerView === "auto" ? e.slidesPerViewDynamic() : t.slidesPerView;
  let i = e.clickedIndex,
    o;
  if (t.loop) {
    if (e.animating) return;
    (o = parseInt(H(e.clickedSlide).attr("data-swiper-slide-index"), 10)),
      t.centeredSlides
        ? i < e.loopedSlides - r / 2 ||
          i > e.slides.length - e.loopedSlides + r / 2
          ? (e.loopFix(),
            (i = n
              .children(
                `.${t.slideClass}[data-swiper-slide-index="${o}"]:not(.${t.slideDuplicateClass})`
              )
              .eq(0)
              .index()),
            ar(() => {
              e.slideTo(i);
            }))
          : e.slideTo(i)
        : i > e.slides.length - r
        ? (e.loopFix(),
          (i = n
            .children(
              `.${t.slideClass}[data-swiper-slide-index="${o}"]:not(.${t.slideDuplicateClass})`
            )
            .eq(0)
            .index()),
          ar(() => {
            e.slideTo(i);
          }))
        : e.slideTo(i);
  } else e.slideTo(i);
}
var dy = {
  slideTo: oy,
  slideToLoop: ly,
  slideNext: sy,
  slidePrev: ay,
  slideReset: uy,
  slideToClosest: cy,
  slideToClickedSlide: fy,
};
function py() {
  const e = this,
    t = He(),
    { params: n, $wrapperEl: r } = e,
    i = r.children().length > 0 ? H(r.children()[0].parentNode) : r;
  i.children(`.${n.slideClass}.${n.slideDuplicateClass}`).remove();
  let o = i.children(`.${n.slideClass}`);
  if (n.loopFillGroupWithBlank) {
    const s = n.slidesPerGroup - (o.length % n.slidesPerGroup);
    if (s !== n.slidesPerGroup) {
      for (let u = 0; u < s; u += 1) {
        const c = H(t.createElement("div")).addClass(
          `${n.slideClass} ${n.slideBlankClass}`
        );
        i.append(c);
      }
      o = i.children(`.${n.slideClass}`);
    }
  }
  n.slidesPerView === "auto" && !n.loopedSlides && (n.loopedSlides = o.length),
    (e.loopedSlides = Math.ceil(
      parseFloat(n.loopedSlides || n.slidesPerView, 10)
    )),
    (e.loopedSlides += n.loopAdditionalSlides),
    e.loopedSlides > o.length &&
      e.params.loopedSlidesLimit &&
      (e.loopedSlides = o.length);
  const l = [],
    a = [];
  o.each((s, u) => {
    H(s).attr("data-swiper-slide-index", u);
  });
  for (let s = 0; s < e.loopedSlides; s += 1) {
    const u = s - Math.floor(s / o.length) * o.length;
    a.push(o.eq(u)[0]), l.unshift(o.eq(o.length - u - 1)[0]);
  }
  for (let s = 0; s < a.length; s += 1)
    i.append(H(a[s].cloneNode(!0)).addClass(n.slideDuplicateClass));
  for (let s = l.length - 1; s >= 0; s -= 1)
    i.prepend(H(l[s].cloneNode(!0)).addClass(n.slideDuplicateClass));
}
function hy() {
  const e = this;
  e.emit("beforeLoopFix");
  const {
    activeIndex: t,
    slides: n,
    loopedSlides: r,
    allowSlidePrev: i,
    allowSlideNext: o,
    snapGrid: l,
    rtlTranslate: a,
  } = e;
  let s;
  (e.allowSlidePrev = !0), (e.allowSlideNext = !0);
  const c = -l[t] - e.getTranslate();
  t < r
    ? ((s = n.length - r * 3 + t),
      (s += r),
      e.slideTo(s, 0, !1, !0) &&
        c !== 0 &&
        e.setTranslate((a ? -e.translate : e.translate) - c))
    : t >= n.length - r &&
      ((s = -n.length + t + r),
      (s += r),
      e.slideTo(s, 0, !1, !0) &&
        c !== 0 &&
        e.setTranslate((a ? -e.translate : e.translate) - c)),
    (e.allowSlidePrev = i),
    (e.allowSlideNext = o),
    e.emit("loopFix");
}
function my() {
  const e = this,
    { $wrapperEl: t, params: n, slides: r } = e;
  t
    .children(
      `.${n.slideClass}.${n.slideDuplicateClass},.${n.slideClass}.${n.slideBlankClass}`
    )
    .remove(),
    r.removeAttr("data-swiper-slide-index");
}
var vy = { loopCreate: py, loopFix: hy, loopDestroy: my };
function gy(e) {
  const t = this;
  if (
    t.support.touch ||
    !t.params.simulateTouch ||
    (t.params.watchOverflow && t.isLocked) ||
    t.params.cssMode
  )
    return;
  const n = t.params.touchEventsTarget === "container" ? t.el : t.wrapperEl;
  (n.style.cursor = "move"), (n.style.cursor = e ? "grabbing" : "grab");
}
function yy() {
  const e = this;
  e.support.touch ||
    (e.params.watchOverflow && e.isLocked) ||
    e.params.cssMode ||
    (e[
      e.params.touchEventsTarget === "container" ? "el" : "wrapperEl"
    ].style.cursor = "");
}
var Sy = { setGrabCursor: gy, unsetGrabCursor: yy };
function wy(e, t = this) {
  function n(r) {
    if (!r || r === He() || r === Ce()) return null;
    r.assignedSlot && (r = r.assignedSlot);
    const i = r.closest(e);
    return !i && !r.getRootNode ? null : i || n(r.getRootNode().host);
  }
  return n(t);
}
function xy(e) {
  const t = this,
    n = He(),
    r = Ce(),
    i = t.touchEventsData,
    { params: o, touches: l, enabled: a } = t;
  if (!a || (t.animating && o.preventInteractionOnTransition)) return;
  !t.animating && o.cssMode && o.loop && t.loopFix();
  let s = e;
  s.originalEvent && (s = s.originalEvent);
  let u = H(s.target);
  if (
    (o.touchEventsTarget === "wrapper" && !u.closest(t.wrapperEl).length) ||
    ((i.isTouchEvent = s.type === "touchstart"),
    !i.isTouchEvent && "which" in s && s.which === 3) ||
    (!i.isTouchEvent && "button" in s && s.button > 0) ||
    (i.isTouched && i.isMoved)
  )
    return;
  const c = !!o.noSwipingClass && o.noSwipingClass !== "",
    f = e.composedPath ? e.composedPath() : e.path;
  c && s.target && s.target.shadowRoot && f && (u = H(f[0]));
  const d = o.noSwipingSelector ? o.noSwipingSelector : `.${o.noSwipingClass}`,
    v = !!(s.target && s.target.shadowRoot);
  if (o.noSwiping && (v ? wy(d, u[0]) : u.closest(d)[0])) {
    t.allowClick = !0;
    return;
  }
  if (o.swipeHandler && !u.closest(o.swipeHandler)[0]) return;
  (l.currentX = s.type === "touchstart" ? s.targetTouches[0].pageX : s.pageX),
    (l.currentY = s.type === "touchstart" ? s.targetTouches[0].pageY : s.pageY);
  const g = l.currentX,
    y = l.currentY,
    x = o.edgeSwipeDetection || o.iOSEdgeSwipeDetection,
    h = o.edgeSwipeThreshold || o.iOSEdgeSwipeThreshold;
  if (x && (g <= h || g >= r.innerWidth - h))
    if (x === "prevent") e.preventDefault();
    else return;
  if (
    (Object.assign(i, {
      isTouched: !0,
      isMoved: !1,
      allowTouchCallbacks: !0,
      isScrolling: void 0,
      startMoving: void 0,
    }),
    (l.startX = g),
    (l.startY = y),
    (i.touchStartTime = qe()),
    (t.allowClick = !0),
    t.updateSize(),
    (t.swipeDirection = void 0),
    o.threshold > 0 && (i.allowThresholdMove = !1),
    s.type !== "touchstart")
  ) {
    let p = !0;
    u.is(i.focusableElements) &&
      ((p = !1), u[0].nodeName === "SELECT" && (i.isTouched = !1)),
      n.activeElement &&
        H(n.activeElement).is(i.focusableElements) &&
        n.activeElement !== u[0] &&
        n.activeElement.blur();
    const m = p && t.allowTouchMove && o.touchStartPreventDefault;
    (o.touchStartForcePreventDefault || m) &&
      !u[0].isContentEditable &&
      s.preventDefault();
  }
  t.params.freeMode &&
    t.params.freeMode.enabled &&
    t.freeMode &&
    t.animating &&
    !o.cssMode &&
    t.freeMode.onTouchStart(),
    t.emit("touchStart", s);
}
function Cy(e) {
  const t = He(),
    n = this,
    r = n.touchEventsData,
    { params: i, touches: o, rtlTranslate: l, enabled: a } = n;
  if (!a) return;
  let s = e;
  if ((s.originalEvent && (s = s.originalEvent), !r.isTouched)) {
    r.startMoving && r.isScrolling && n.emit("touchMoveOpposite", s);
    return;
  }
  if (r.isTouchEvent && s.type !== "touchmove") return;
  const u =
      s.type === "touchmove" &&
      s.targetTouches &&
      (s.targetTouches[0] || s.changedTouches[0]),
    c = s.type === "touchmove" ? u.pageX : s.pageX,
    f = s.type === "touchmove" ? u.pageY : s.pageY;
  if (s.preventedByNestedSwiper) {
    (o.startX = c), (o.startY = f);
    return;
  }
  if (!n.allowTouchMove) {
    H(s.target).is(r.focusableElements) || (n.allowClick = !1),
      r.isTouched &&
        (Object.assign(o, { startX: c, startY: f, currentX: c, currentY: f }),
        (r.touchStartTime = qe()));
    return;
  }
  if (r.isTouchEvent && i.touchReleaseOnEdges && !i.loop) {
    if (n.isVertical()) {
      if (
        (f < o.startY && n.translate <= n.maxTranslate()) ||
        (f > o.startY && n.translate >= n.minTranslate())
      ) {
        (r.isTouched = !1), (r.isMoved = !1);
        return;
      }
    } else if (
      (c < o.startX && n.translate <= n.maxTranslate()) ||
      (c > o.startX && n.translate >= n.minTranslate())
    )
      return;
  }
  if (
    r.isTouchEvent &&
    t.activeElement &&
    s.target === t.activeElement &&
    H(s.target).is(r.focusableElements)
  ) {
    (r.isMoved = !0), (n.allowClick = !1);
    return;
  }
  if (
    (r.allowTouchCallbacks && n.emit("touchMove", s),
    s.targetTouches && s.targetTouches.length > 1)
  )
    return;
  (o.currentX = c), (o.currentY = f);
  const d = o.currentX - o.startX,
    v = o.currentY - o.startY;
  if (n.params.threshold && Math.sqrt(d ** 2 + v ** 2) < n.params.threshold)
    return;
  if (typeof r.isScrolling == "undefined") {
    let h;
    (n.isHorizontal() && o.currentY === o.startY) ||
    (n.isVertical() && o.currentX === o.startX)
      ? (r.isScrolling = !1)
      : d * d + v * v >= 25 &&
        ((h = (Math.atan2(Math.abs(v), Math.abs(d)) * 180) / Math.PI),
        (r.isScrolling = n.isHorizontal()
          ? h > i.touchAngle
          : 90 - h > i.touchAngle));
  }
  if (
    (r.isScrolling && n.emit("touchMoveOpposite", s),
    typeof r.startMoving == "undefined" &&
      (o.currentX !== o.startX || o.currentY !== o.startY) &&
      (r.startMoving = !0),
    r.isScrolling)
  ) {
    r.isTouched = !1;
    return;
  }
  if (!r.startMoving) return;
  (n.allowClick = !1),
    !i.cssMode && s.cancelable && s.preventDefault(),
    i.touchMoveStopPropagation && !i.nested && s.stopPropagation(),
    r.isMoved ||
      (i.loop && !i.cssMode && n.loopFix(),
      (r.startTranslate = n.getTranslate()),
      n.setTransition(0),
      n.animating && n.$wrapperEl.trigger("webkitTransitionEnd transitionend"),
      (r.allowMomentumBounce = !1),
      i.grabCursor &&
        (n.allowSlideNext === !0 || n.allowSlidePrev === !0) &&
        n.setGrabCursor(!0),
      n.emit("sliderFirstMove", s)),
    n.emit("sliderMove", s),
    (r.isMoved = !0);
  let g = n.isHorizontal() ? d : v;
  (o.diff = g),
    (g *= i.touchRatio),
    l && (g = -g),
    (n.swipeDirection = g > 0 ? "prev" : "next"),
    (r.currentTranslate = g + r.startTranslate);
  let y = !0,
    x = i.resistanceRatio;
  if (
    (i.touchReleaseOnEdges && (x = 0),
    g > 0 && r.currentTranslate > n.minTranslate()
      ? ((y = !1),
        i.resistance &&
          (r.currentTranslate =
            n.minTranslate() -
            1 +
            (-n.minTranslate() + r.startTranslate + g) ** x))
      : g < 0 &&
        r.currentTranslate < n.maxTranslate() &&
        ((y = !1),
        i.resistance &&
          (r.currentTranslate =
            n.maxTranslate() +
            1 -
            (n.maxTranslate() - r.startTranslate - g) ** x)),
    y && (s.preventedByNestedSwiper = !0),
    !n.allowSlideNext &&
      n.swipeDirection === "next" &&
      r.currentTranslate < r.startTranslate &&
      (r.currentTranslate = r.startTranslate),
    !n.allowSlidePrev &&
      n.swipeDirection === "prev" &&
      r.currentTranslate > r.startTranslate &&
      (r.currentTranslate = r.startTranslate),
    !n.allowSlidePrev &&
      !n.allowSlideNext &&
      (r.currentTranslate = r.startTranslate),
    i.threshold > 0)
  )
    if (Math.abs(g) > i.threshold || r.allowThresholdMove) {
      if (!r.allowThresholdMove) {
        (r.allowThresholdMove = !0),
          (o.startX = o.currentX),
          (o.startY = o.currentY),
          (r.currentTranslate = r.startTranslate),
          (o.diff = n.isHorizontal()
            ? o.currentX - o.startX
            : o.currentY - o.startY);
        return;
      }
    } else {
      r.currentTranslate = r.startTranslate;
      return;
    }
  !i.followFinger ||
    i.cssMode ||
    (((i.freeMode && i.freeMode.enabled && n.freeMode) ||
      i.watchSlidesProgress) &&
      (n.updateActiveIndex(), n.updateSlidesClasses()),
    n.params.freeMode &&
      i.freeMode.enabled &&
      n.freeMode &&
      n.freeMode.onTouchMove(),
    n.updateProgress(r.currentTranslate),
    n.setTranslate(r.currentTranslate));
}
function Ey(e) {
  const t = this,
    n = t.touchEventsData,
    { params: r, touches: i, rtlTranslate: o, slidesGrid: l, enabled: a } = t;
  if (!a) return;
  let s = e;
  if (
    (s.originalEvent && (s = s.originalEvent),
    n.allowTouchCallbacks && t.emit("touchEnd", s),
    (n.allowTouchCallbacks = !1),
    !n.isTouched)
  ) {
    n.isMoved && r.grabCursor && t.setGrabCursor(!1),
      (n.isMoved = !1),
      (n.startMoving = !1);
    return;
  }
  r.grabCursor &&
    n.isMoved &&
    n.isTouched &&
    (t.allowSlideNext === !0 || t.allowSlidePrev === !0) &&
    t.setGrabCursor(!1);
  const u = qe(),
    c = u - n.touchStartTime;
  if (t.allowClick) {
    const p = s.path || (s.composedPath && s.composedPath());
    t.updateClickedSlide((p && p[0]) || s.target),
      t.emit("tap click", s),
      c < 300 &&
        u - n.lastClickTime < 300 &&
        t.emit("doubleTap doubleClick", s);
  }
  if (
    ((n.lastClickTime = qe()),
    ar(() => {
      t.destroyed || (t.allowClick = !0);
    }),
    !n.isTouched ||
      !n.isMoved ||
      !t.swipeDirection ||
      i.diff === 0 ||
      n.currentTranslate === n.startTranslate)
  ) {
    (n.isTouched = !1), (n.isMoved = !1), (n.startMoving = !1);
    return;
  }
  (n.isTouched = !1), (n.isMoved = !1), (n.startMoving = !1);
  let f;
  if (
    (r.followFinger
      ? (f = o ? t.translate : -t.translate)
      : (f = -n.currentTranslate),
    r.cssMode)
  )
    return;
  if (t.params.freeMode && r.freeMode.enabled) {
    t.freeMode.onTouchEnd({ currentPos: f });
    return;
  }
  let d = 0,
    v = t.slidesSizesGrid[0];
  for (
    let p = 0;
    p < l.length;
    p += p < r.slidesPerGroupSkip ? 1 : r.slidesPerGroup
  ) {
    const m = p < r.slidesPerGroupSkip - 1 ? 1 : r.slidesPerGroup;
    typeof l[p + m] != "undefined"
      ? f >= l[p] && f < l[p + m] && ((d = p), (v = l[p + m] - l[p]))
      : f >= l[p] && ((d = p), (v = l[l.length - 1] - l[l.length - 2]));
  }
  let g = null,
    y = null;
  r.rewind &&
    (t.isBeginning
      ? (y =
          t.params.virtual && t.params.virtual.enabled && t.virtual
            ? t.virtual.slides.length - 1
            : t.slides.length - 1)
      : t.isEnd && (g = 0));
  const x = (f - l[d]) / v,
    h = d < r.slidesPerGroupSkip - 1 ? 1 : r.slidesPerGroup;
  if (c > r.longSwipesMs) {
    if (!r.longSwipes) {
      t.slideTo(t.activeIndex);
      return;
    }
    t.swipeDirection === "next" &&
      (x >= r.longSwipesRatio
        ? t.slideTo(r.rewind && t.isEnd ? g : d + h)
        : t.slideTo(d)),
      t.swipeDirection === "prev" &&
        (x > 1 - r.longSwipesRatio
          ? t.slideTo(d + h)
          : y !== null && x < 0 && Math.abs(x) > r.longSwipesRatio
          ? t.slideTo(y)
          : t.slideTo(d));
  } else {
    if (!r.shortSwipes) {
      t.slideTo(t.activeIndex);
      return;
    }
    t.navigation &&
    (s.target === t.navigation.nextEl || s.target === t.navigation.prevEl)
      ? s.target === t.navigation.nextEl
        ? t.slideTo(d + h)
        : t.slideTo(d)
      : (t.swipeDirection === "next" && t.slideTo(g !== null ? g : d + h),
        t.swipeDirection === "prev" && t.slideTo(y !== null ? y : d));
  }
}
function Hc() {
  const e = this,
    { params: t, el: n } = e;
  if (n && n.offsetWidth === 0) return;
  t.breakpoints && e.setBreakpoint();
  const { allowSlideNext: r, allowSlidePrev: i, snapGrid: o } = e;
  (e.allowSlideNext = !0),
    (e.allowSlidePrev = !0),
    e.updateSize(),
    e.updateSlides(),
    e.updateSlidesClasses(),
    (t.slidesPerView === "auto" || t.slidesPerView > 1) &&
    e.isEnd &&
    !e.isBeginning &&
    !e.params.centeredSlides
      ? e.slideTo(e.slides.length - 1, 0, !1, !0)
      : e.slideTo(e.activeIndex, 0, !1, !0),
    e.autoplay && e.autoplay.running && e.autoplay.paused && e.autoplay.run(),
    (e.allowSlidePrev = i),
    (e.allowSlideNext = r),
    e.params.watchOverflow && o !== e.snapGrid && e.checkOverflow();
}
function Ty(e) {
  const t = this;
  !t.enabled ||
    t.allowClick ||
    (t.params.preventClicks && e.preventDefault(),
    t.params.preventClicksPropagation &&
      t.animating &&
      (e.stopPropagation(), e.stopImmediatePropagation()));
}
function ky() {
  const e = this,
    { wrapperEl: t, rtlTranslate: n, enabled: r } = e;
  if (!r) return;
  (e.previousTranslate = e.translate),
    e.isHorizontal()
      ? (e.translate = -t.scrollLeft)
      : (e.translate = -t.scrollTop),
    e.translate === 0 && (e.translate = 0),
    e.updateActiveIndex(),
    e.updateSlidesClasses();
  let i;
  const o = e.maxTranslate() - e.minTranslate();
  o === 0 ? (i = 0) : (i = (e.translate - e.minTranslate()) / o),
    i !== e.progress && e.updateProgress(n ? -e.translate : e.translate),
    e.emit("setTranslate", e.translate, !1);
}
let Uc = !1;
function Py() {}
const Wp = (e, t) => {
  const n = He(),
    {
      params: r,
      touchEvents: i,
      el: o,
      wrapperEl: l,
      device: a,
      support: s,
    } = e,
    u = !!r.nested,
    c = t === "on" ? "addEventListener" : "removeEventListener",
    f = t;
  if (!s.touch)
    o[c](i.start, e.onTouchStart, !1),
      n[c](i.move, e.onTouchMove, u),
      n[c](i.end, e.onTouchEnd, !1);
  else {
    const d =
      i.start === "touchstart" && s.passiveListener && r.passiveListeners
        ? { passive: !0, capture: !1 }
        : !1;
    o[c](i.start, e.onTouchStart, d),
      o[c](
        i.move,
        e.onTouchMove,
        s.passiveListener ? { passive: !1, capture: u } : u
      ),
      o[c](i.end, e.onTouchEnd, d),
      i.cancel && o[c](i.cancel, e.onTouchEnd, d);
  }
  (r.preventClicks || r.preventClicksPropagation) &&
    o[c]("click", e.onClick, !0),
    r.cssMode && l[c]("scroll", e.onScroll),
    r.updateOnWindowResize
      ? e[f](
          a.ios || a.android
            ? "resize orientationchange observerUpdate"
            : "resize observerUpdate",
          Hc,
          !0
        )
      : e[f]("observerUpdate", Hc, !0);
};
function $y() {
  const e = this,
    t = He(),
    { params: n, support: r } = e;
  (e.onTouchStart = xy.bind(e)),
    (e.onTouchMove = Cy.bind(e)),
    (e.onTouchEnd = Ey.bind(e)),
    n.cssMode && (e.onScroll = ky.bind(e)),
    (e.onClick = Ty.bind(e)),
    r.touch && !Uc && (t.addEventListener("touchstart", Py), (Uc = !0)),
    Wp(e, "on");
}
function _y() {
  Wp(this, "off");
}
var Ly = { attachEvents: $y, detachEvents: _y };
const Wc = (e, t) => e.grid && t.grid && t.grid.rows > 1;
function Oy() {
  const e = this,
    {
      activeIndex: t,
      initialized: n,
      loopedSlides: r = 0,
      params: i,
      $el: o,
    } = e,
    l = i.breakpoints;
  if (!l || (l && Object.keys(l).length === 0)) return;
  const a = e.getBreakpoint(l, e.params.breakpointsBase, e.el);
  if (!a || e.currentBreakpoint === a) return;
  const u = (a in l ? l[a] : void 0) || e.originalParams,
    c = Wc(e, i),
    f = Wc(e, u),
    d = i.enabled;
  c && !f
    ? (o.removeClass(
        `${i.containerModifierClass}grid ${i.containerModifierClass}grid-column`
      ),
      e.emitContainerClasses())
    : !c &&
      f &&
      (o.addClass(`${i.containerModifierClass}grid`),
      ((u.grid.fill && u.grid.fill === "column") ||
        (!u.grid.fill && i.grid.fill === "column")) &&
        o.addClass(`${i.containerModifierClass}grid-column`),
      e.emitContainerClasses()),
    ["navigation", "pagination", "scrollbar"].forEach((x) => {
      const h = i[x] && i[x].enabled,
        p = u[x] && u[x].enabled;
      h && !p && e[x].disable(), !h && p && e[x].enable();
    });
  const v = u.direction && u.direction !== i.direction,
    g = i.loop && (u.slidesPerView !== i.slidesPerView || v);
  v && n && e.changeDirection(), Ze(e.params, u);
  const y = e.params.enabled;
  Object.assign(e, {
    allowTouchMove: e.params.allowTouchMove,
    allowSlideNext: e.params.allowSlideNext,
    allowSlidePrev: e.params.allowSlidePrev,
  }),
    d && !y ? e.disable() : !d && y && e.enable(),
    (e.currentBreakpoint = a),
    e.emit("_beforeBreakpoint", u),
    g &&
      n &&
      (e.loopDestroy(),
      e.loopCreate(),
      e.updateSlides(),
      e.slideTo(t - r + e.loopedSlides, 0, !1)),
    e.emit("breakpoint", u);
}
function My(e, t = "window", n) {
  if (!e || (t === "container" && !n)) return;
  let r = !1;
  const i = Ce(),
    o = t === "window" ? i.innerHeight : n.clientHeight,
    l = Object.keys(e).map((a) => {
      if (typeof a == "string" && a.indexOf("@") === 0) {
        const s = parseFloat(a.substr(1));
        return { value: o * s, point: a };
      }
      return { value: a, point: a };
    });
  l.sort((a, s) => parseInt(a.value, 10) - parseInt(s.value, 10));
  for (let a = 0; a < l.length; a += 1) {
    const { point: s, value: u } = l[a];
    t === "window"
      ? i.matchMedia(`(min-width: ${u}px)`).matches && (r = s)
      : u <= n.clientWidth && (r = s);
  }
  return r || "max";
}
var Ny = { setBreakpoint: Oy, getBreakpoint: My };
function Ay(e, t) {
  const n = [];
  return (
    e.forEach((r) => {
      typeof r == "object"
        ? Object.keys(r).forEach((i) => {
            r[i] && n.push(t + i);
          })
        : typeof r == "string" && n.push(t + r);
    }),
    n
  );
}
function zy() {
  const e = this,
    { classNames: t, params: n, rtl: r, $el: i, device: o, support: l } = e,
    a = Ay(
      [
        "initialized",
        n.direction,
        { "pointer-events": !l.touch },
        { "free-mode": e.params.freeMode && n.freeMode.enabled },
        { autoheight: n.autoHeight },
        { rtl: r },
        { grid: n.grid && n.grid.rows > 1 },
        {
          "grid-column": n.grid && n.grid.rows > 1 && n.grid.fill === "column",
        },
        { android: o.android },
        { ios: o.ios },
        { "css-mode": n.cssMode },
        { centered: n.cssMode && n.centeredSlides },
        { "watch-progress": n.watchSlidesProgress },
      ],
      n.containerModifierClass
    );
  t.push(...a), i.addClass([...t].join(" ")), e.emitContainerClasses();
}
function Ry() {
  const e = this,
    { $el: t, classNames: n } = e;
  t.removeClass(n.join(" ")), e.emitContainerClasses();
}
var Iy = { addClasses: zy, removeClasses: Ry };
function by(e, t, n, r, i, o) {
  const l = Ce();
  let a;
  function s() {
    o && o();
  }
  !H(e).parent("picture")[0] && (!e.complete || !i) && t
    ? ((a = new l.Image()),
      (a.onload = s),
      (a.onerror = s),
      r && (a.sizes = r),
      n && (a.srcset = n),
      t && (a.src = t))
    : s();
}
function Dy() {
  // const e = this;
  // e.imagesToLoad = e.$el.find("img");
  // function t() {
  //   typeof e == "undefined" ||
  //     e === null ||
  //     !e ||
  //     e.destroyed ||
  //     (e.imagesLoaded !== void 0 && (e.imagesLoaded += 1),
  //     e.imagesLoaded === e.imagesToLoad.length &&
  //       (e.params.updateOnImagesReady && e.update(), e.emit("imagesReady")));
  // }
  // for (let n = 0; n < e.imagesToLoad.length; n += 1) {
  //   const r = e.imagesToLoad[n];
  //   e.loadImage(
  //     r,
  //     r.currentSrc || r.getAttribute("src"),
  //     r.srcset || r.getAttribute("srcset"),
  //     r.sizes || r.getAttribute("sizes"),
  //     !0,
  //     t
  //   );
  // }
}
var jy = { loadImage: by, preloadImages: Dy };
function Fy() {
  const e = this,
    { isLocked: t, params: n } = e,
    { slidesOffsetBefore: r } = n;
  if (r) {
    const i = e.slides.length - 1,
      o = e.slidesGrid[i] + e.slidesSizesGrid[i] + r * 2;
    e.isLocked = e.size > o;
  } else e.isLocked = e.snapGrid.length === 1;
  n.allowSlideNext === !0 && (e.allowSlideNext = !e.isLocked),
    n.allowSlidePrev === !0 && (e.allowSlidePrev = !e.isLocked),
    t && t !== e.isLocked && (e.isEnd = !1),
    t !== e.isLocked && e.emit(e.isLocked ? "lock" : "unlock");
}
var By = { checkOverflow: Fy },
  Gc = {
    init: !0,
    direction: "horizontal",
    touchEventsTarget: "wrapper",
    initialSlide: 0,
    speed: 300,
    cssMode: !1,
    updateOnWindowResize: !0,
    resizeObserver: !0,
    nested: !1,
    createElements: !1,
    enabled: !0,
    focusableElements: "input, select, option, textarea, button, video, label",
    width: null,
    height: null,
    preventInteractionOnTransition: !1,
    userAgent: null,
    url: null,
    edgeSwipeDetection: !1,
    edgeSwipeThreshold: 20,
    autoHeight: !1,
    setWrapperSize: !1,
    virtualTranslate: !1,
    effect: "slide",
    breakpoints: void 0,
    breakpointsBase: "window",
    spaceBetween: 0,
    slidesPerView: 1,
    slidesPerGroup: 1,
    slidesPerGroupSkip: 0,
    slidesPerGroupAuto: !1,
    centeredSlides: !1,
    centeredSlidesBounds: !1,
    slidesOffsetBefore: 0,
    slidesOffsetAfter: 0,
    normalizeSlideIndex: !0,
    centerInsufficientSlides: !1,
    watchOverflow: !0,
    roundLengths: !1,
    touchRatio: 1,
    touchAngle: 45,
    simulateTouch: !0,
    shortSwipes: !0,
    longSwipes: !0,
    longSwipesRatio: 0.5,
    longSwipesMs: 300,
    followFinger: !0,
    allowTouchMove: !0,
    threshold: 0,
    touchMoveStopPropagation: !1,
    touchStartPreventDefault: !0,
    touchStartForcePreventDefault: !1,
    touchReleaseOnEdges: !1,
    uniqueNavElements: !0,
    resistance: !0,
    resistanceRatio: 0.85,
    watchSlidesProgress: !1,
    grabCursor: !1,
    preventClicks: !0,
    preventClicksPropagation: !0,
    slideToClickedSlide: !1,
    preloadImages: !0,
    updateOnImagesReady: !0,
    loop: !1,
    loopAdditionalSlides: 0,
    loopedSlides: null,
    loopedSlidesLimit: !0,
    loopFillGroupWithBlank: !1,
    loopPreventsSlide: !0,
    rewind: !1,
    allowSlidePrev: !0,
    allowSlideNext: !0,
    swipeHandler: null,
    noSwiping: !0,
    noSwipingClass: "swiper-no-swiping",
    noSwipingSelector: null,
    passiveListeners: !0,
    maxBackfaceHiddenSlides: 10,
    containerModifierClass: "swiper-",
    slideClass: "swiper-slide",
    slideBlankClass: "swiper-slide-invisible-blank",
    slideActiveClass: "swiper-slide-active",
    slideDuplicateActiveClass: "swiper-slide-duplicate-active",
    slideVisibleClass: "swiper-slide-visible",
    slideDuplicateClass: "swiper-slide-duplicate",
    slideNextClass: "swiper-slide-next",
    slideDuplicateNextClass: "swiper-slide-duplicate-next",
    slidePrevClass: "swiper-slide-prev",
    slideDuplicatePrevClass: "swiper-slide-duplicate-prev",
    wrapperClass: "swiper-wrapper",
    runCallbacksOnInit: !0,
    _emitClasses: !1,
  };
function Vy(e, t) {
  return function (r = {}) {
    const i = Object.keys(r)[0],
      o = r[i];
    if (typeof o != "object" || o === null) {
      Ze(t, r);
      return;
    }
    if (
      (["navigation", "pagination", "scrollbar"].indexOf(i) >= 0 &&
        e[i] === !0 &&
        (e[i] = { auto: !0 }),
      !(i in e && "enabled" in o))
    ) {
      Ze(t, r);
      return;
    }
    e[i] === !0 && (e[i] = { enabled: !0 }),
      typeof e[i] == "object" && !("enabled" in e[i]) && (e[i].enabled = !0),
      e[i] || (e[i] = { enabled: !1 }),
      Ze(t, r);
  };
}
const Vl = {
    eventsEmitter: D1,
    update: X1,
    translate: ey,
    transition: iy,
    slide: dy,
    loop: vy,
    grabCursor: Sy,
    events: Ly,
    breakpoints: Ny,
    checkOverflow: By,
    classes: Iy,
    images: jy,
  },
  Hl = {};
class je {
  constructor(...t) {
    let n, r;
    if (
      (t.length === 1 &&
      t[0].constructor &&
      Object.prototype.toString.call(t[0]).slice(8, -1) === "Object"
        ? (r = t[0])
        : ([n, r] = t),
      r || (r = {}),
      (r = Ze({}, r)),
      n && !r.el && (r.el = n),
      r.el && H(r.el).length > 1)
    ) {
      const a = [];
      return (
        H(r.el).each((s) => {
          const u = Ze({}, r, { el: s });
          a.push(new je(u));
        }),
        a
      );
    }
    const i = this;
    (i.__swiper__ = !0),
      (i.support = Hp()),
      (i.device = A1({ userAgent: r.userAgent })),
      (i.browser = R1()),
      (i.eventsListeners = {}),
      (i.eventsAnyListeners = []),
      (i.modules = [...i.__modules__]),
      r.modules && Array.isArray(r.modules) && i.modules.push(...r.modules);
    const o = {};
    i.modules.forEach((a) => {
      a({
        swiper: i,
        extendParams: Vy(r, o),
        on: i.on.bind(i),
        once: i.once.bind(i),
        off: i.off.bind(i),
        emit: i.emit.bind(i),
      });
    });
    const l = Ze({}, Gc, o);
    return (
      (i.params = Ze({}, l, Hl, r)),
      (i.originalParams = Ze({}, i.params)),
      (i.passedParams = Ze({}, r)),
      i.params &&
        i.params.on &&
        Object.keys(i.params.on).forEach((a) => {
          i.on(a, i.params.on[a]);
        }),
      i.params && i.params.onAny && i.onAny(i.params.onAny),
      (i.$ = H),
      Object.assign(i, {
        enabled: i.params.enabled,
        el: n,
        classNames: [],
        slides: H(),
        slidesGrid: [],
        snapGrid: [],
        slidesSizesGrid: [],
        isHorizontal() {
          return i.params.direction === "horizontal";
        },
        isVertical() {
          return i.params.direction === "vertical";
        },
        activeIndex: 0,
        realIndex: 0,
        isBeginning: !0,
        isEnd: !1,
        translate: 0,
        previousTranslate: 0,
        progress: 0,
        velocity: 0,
        animating: !1,
        allowSlideNext: i.params.allowSlideNext,
        allowSlidePrev: i.params.allowSlidePrev,
        touchEvents: (function () {
          const s = ["touchstart", "touchmove", "touchend", "touchcancel"],
            u = ["pointerdown", "pointermove", "pointerup"];
          return (
            (i.touchEventsTouch = {
              start: s[0],
              move: s[1],
              end: s[2],
              cancel: s[3],
            }),
            (i.touchEventsDesktop = { start: u[0], move: u[1], end: u[2] }),
            i.support.touch || !i.params.simulateTouch
              ? i.touchEventsTouch
              : i.touchEventsDesktop
          );
        })(),
        touchEventsData: {
          isTouched: void 0,
          isMoved: void 0,
          allowTouchCallbacks: void 0,
          touchStartTime: void 0,
          isScrolling: void 0,
          currentTranslate: void 0,
          startTranslate: void 0,
          allowThresholdMove: void 0,
          focusableElements: i.params.focusableElements,
          lastClickTime: qe(),
          clickTimeout: void 0,
          velocities: [],
          allowMomentumBounce: void 0,
          isTouchEvent: void 0,
          startMoving: void 0,
        },
        allowClick: !0,
        allowTouchMove: i.params.allowTouchMove,
        touches: { startX: 0, startY: 0, currentX: 0, currentY: 0, diff: 0 },
        imagesToLoad: [],
        imagesLoaded: 0,
      }),
      i.emit("_swiper"),
      i.params.init && i.init(),
      i
    );
  }
  enable() {
    const t = this;
    t.enabled ||
      ((t.enabled = !0),
      t.params.grabCursor && t.setGrabCursor(),
      t.emit("enable"));
  }
  disable() {
    const t = this;
    !t.enabled ||
      ((t.enabled = !1),
      t.params.grabCursor && t.unsetGrabCursor(),
      t.emit("disable"));
  }
  setProgress(t, n) {
    const r = this;
    t = Math.min(Math.max(t, 0), 1);
    const i = r.minTranslate(),
      l = (r.maxTranslate() - i) * t + i;
    r.translateTo(l, typeof n == "undefined" ? 0 : n),
      r.updateActiveIndex(),
      r.updateSlidesClasses();
  }
  emitContainerClasses() {
    const t = this;
    if (!t.params._emitClasses || !t.el) return;
    const n = t.el.className
      .split(" ")
      .filter(
        (r) =>
          r.indexOf("swiper") === 0 ||
          r.indexOf(t.params.containerModifierClass) === 0
      );
    t.emit("_containerClasses", n.join(" "));
  }
  getSlideClasses(t) {
    const n = this;
    return n.destroyed
      ? ""
      : t.className
          .split(" ")
          .filter(
            (r) =>
              r.indexOf("swiper-slide") === 0 ||
              r.indexOf(n.params.slideClass) === 0
          )
          .join(" ");
  }
  emitSlidesClasses() {
    const t = this;
    if (!t.params._emitClasses || !t.el) return;
    const n = [];
    t.slides.each((r) => {
      const i = t.getSlideClasses(r);
      n.push({ slideEl: r, classNames: i }), t.emit("_slideClass", r, i);
    }),
      t.emit("_slideClasses", n);
  }
  slidesPerViewDynamic(t = "current", n = !1) {
    const r = this,
      {
        params: i,
        slides: o,
        slidesGrid: l,
        slidesSizesGrid: a,
        size: s,
        activeIndex: u,
      } = r;
    let c = 1;
    if (i.centeredSlides) {
      let f = o[u].swiperSlideSize,
        d;
      for (let v = u + 1; v < o.length; v += 1)
        o[v] &&
          !d &&
          ((f += o[v].swiperSlideSize), (c += 1), f > s && (d = !0));
      for (let v = u - 1; v >= 0; v -= 1)
        o[v] &&
          !d &&
          ((f += o[v].swiperSlideSize), (c += 1), f > s && (d = !0));
    } else if (t === "current")
      for (let f = u + 1; f < o.length; f += 1)
        (n ? l[f] + a[f] - l[u] < s : l[f] - l[u] < s) && (c += 1);
    else for (let f = u - 1; f >= 0; f -= 1) l[u] - l[f] < s && (c += 1);
    return c;
  }
  update() {
    const t = this;
    if (!t || t.destroyed) return;
    const { snapGrid: n, params: r } = t;
    r.breakpoints && t.setBreakpoint(),
      t.updateSize(),
      t.updateSlides(),
      t.updateProgress(),
      t.updateSlidesClasses();
    function i() {
      const l = t.rtlTranslate ? t.translate * -1 : t.translate,
        a = Math.min(Math.max(l, t.maxTranslate()), t.minTranslate());
      t.setTranslate(a), t.updateActiveIndex(), t.updateSlidesClasses();
    }
    let o;
    t.params.freeMode && t.params.freeMode.enabled
      ? (i(), t.params.autoHeight && t.updateAutoHeight())
      : ((t.params.slidesPerView === "auto" || t.params.slidesPerView > 1) &&
        t.isEnd &&
        !t.params.centeredSlides
          ? (o = t.slideTo(t.slides.length - 1, 0, !1, !0))
          : (o = t.slideTo(t.activeIndex, 0, !1, !0)),
        o || i()),
      r.watchOverflow && n !== t.snapGrid && t.checkOverflow(),
      t.emit("update");
  }
  changeDirection(t, n = !0) {
    const r = this,
      i = r.params.direction;
    return (
      t || (t = i === "horizontal" ? "vertical" : "horizontal"),
      t === i ||
        (t !== "horizontal" && t !== "vertical") ||
        (r.$el
          .removeClass(`${r.params.containerModifierClass}${i}`)
          .addClass(`${r.params.containerModifierClass}${t}`),
        r.emitContainerClasses(),
        (r.params.direction = t),
        r.slides.each((o) => {
          t === "vertical" ? (o.style.width = "") : (o.style.height = "");
        }),
        r.emit("changeDirection"),
        n && r.update()),
      r
    );
  }
  changeLanguageDirection(t) {
    const n = this;
    (n.rtl && t === "rtl") ||
      (!n.rtl && t === "ltr") ||
      ((n.rtl = t === "rtl"),
      (n.rtlTranslate = n.params.direction === "horizontal" && n.rtl),
      n.rtl
        ? (n.$el.addClass(`${n.params.containerModifierClass}rtl`),
          (n.el.dir = "rtl"))
        : (n.$el.removeClass(`${n.params.containerModifierClass}rtl`),
          (n.el.dir = "ltr")),
      n.update());
  }
  mount(t) {
    const n = this;
    if (n.mounted) return !0;
    const r = H(t || n.params.el);
    if (((t = r[0]), !t)) return !1;
    t.swiper = n;
    const i = () =>
      `.${(n.params.wrapperClass || "").trim().split(" ").join(".")}`;
    let l = (() => {
      if (t && t.shadowRoot && t.shadowRoot.querySelector) {
        const a = H(t.shadowRoot.querySelector(i()));
        return (a.children = (s) => r.children(s)), a;
      }
      return r.children ? r.children(i()) : H(r).children(i());
    })();
    if (l.length === 0 && n.params.createElements) {
      const s = He().createElement("div");
      (l = H(s)),
        (s.className = n.params.wrapperClass),
        r.append(s),
        r.children(`.${n.params.slideClass}`).each((u) => {
          l.append(u);
        });
    }
    return (
      Object.assign(n, {
        $el: r,
        el: t,
        $wrapperEl: l,
        wrapperEl: l[0],
        mounted: !0,
        rtl: t.dir.toLowerCase() === "rtl" || r.css("direction") === "rtl",
        rtlTranslate:
          n.params.direction === "horizontal" &&
          (t.dir.toLowerCase() === "rtl" || r.css("direction") === "rtl"),
        wrongRTL: l.css("display") === "-webkit-box",
      }),
      !0
    );
  }
  init(t) {
    const n = this;
    return (
      n.initialized ||
        n.mount(t) === !1 ||
        (n.emit("beforeInit"),
        n.params.breakpoints && n.setBreakpoint(),
        n.addClasses(),
        n.params.loop && n.loopCreate(),
        n.updateSize(),
        n.updateSlides(),
        n.params.watchOverflow && n.checkOverflow(),
        n.params.grabCursor && n.enabled && n.setGrabCursor(),
        n.params.preloadImages && n.preloadImages(),
        n.params.loop
          ? n.slideTo(
              n.params.initialSlide + n.loopedSlides,
              0,
              n.params.runCallbacksOnInit,
              !1,
              !0
            )
          : n.slideTo(
              n.params.initialSlide,
              0,
              n.params.runCallbacksOnInit,
              !1,
              !0
            ),
        n.attachEvents(),
        (n.initialized = !0),
        n.emit("init"),
        n.emit("afterInit")),
      n
    );
  }
  destroy(t = !0, n = !0) {
    const r = this,
      { params: i, $el: o, $wrapperEl: l, slides: a } = r;
    return (
      typeof r.params == "undefined" ||
        r.destroyed ||
        (r.emit("beforeDestroy"),
        (r.initialized = !1),
        r.detachEvents(),
        i.loop && r.loopDestroy(),
        n &&
          (r.removeClasses(),
          o.removeAttr("style"),
          l.removeAttr("style"),
          a &&
            a.length &&
            a
              .removeClass(
                [
                  i.slideVisibleClass,
                  i.slideActiveClass,
                  i.slideNextClass,
                  i.slidePrevClass,
                ].join(" ")
              )
              .removeAttr("style")
              .removeAttr("data-swiper-slide-index")),
        r.emit("destroy"),
        Object.keys(r.eventsListeners).forEach((s) => {
          r.off(s);
        }),
        t !== !1 && ((r.$el[0].swiper = null), $1(r)),
        (r.destroyed = !0)),
      null
    );
  }
  static extendDefaults(t) {
    Ze(Hl, t);
  }
  static get extendedDefaults() {
    return Hl;
  }
  static get defaults() {
    return Gc;
  }
  static installModule(t) {
    je.prototype.__modules__ || (je.prototype.__modules__ = []);
    const n = je.prototype.__modules__;
    typeof t == "function" && n.indexOf(t) < 0 && n.push(t);
  }
  static use(t) {
    return Array.isArray(t)
      ? (t.forEach((n) => je.installModule(n)), je)
      : (je.installModule(t), je);
  }
}
Object.keys(Vl).forEach((e) => {
  Object.keys(Vl[e]).forEach((t) => {
    je.prototype[t] = Vl[e][t];
  });
});
je.use([I1, b1]);
function Hy({ swiper: e, extendParams: t, on: n, emit: r }) {
  const i = Ce();
  t({
    mousewheel: {
      enabled: !1,
      releaseOnEdges: !1,
      invert: !1,
      forceToAxis: !1,
      sensitivity: 1,
      eventsTarget: "container",
      thresholdDelta: null,
      thresholdTime: null,
    },
  }),
    (e.mousewheel = { enabled: !1 });
  let o,
    l = qe(),
    a;
  const s = [];
  function u(p) {
    let P = 0,
      E = 0,
      k = 0,
      D = 0;
    return (
      "detail" in p && (E = p.detail),
      "wheelDelta" in p && (E = -p.wheelDelta / 120),
      "wheelDeltaY" in p && (E = -p.wheelDeltaY / 120),
      "wheelDeltaX" in p && (P = -p.wheelDeltaX / 120),
      "axis" in p && p.axis === p.HORIZONTAL_AXIS && ((P = E), (E = 0)),
      (k = P * 10),
      (D = E * 10),
      "deltaY" in p && (D = p.deltaY),
      "deltaX" in p && (k = p.deltaX),
      p.shiftKey && !k && ((k = D), (D = 0)),
      (k || D) &&
        p.deltaMode &&
        (p.deltaMode === 1 ? ((k *= 40), (D *= 40)) : ((k *= 800), (D *= 800))),
      k && !P && (P = k < 1 ? -1 : 1),
      D && !E && (E = D < 1 ? -1 : 1),
      { spinX: P, spinY: E, pixelX: k, pixelY: D }
    );
  }
  function c() {
    !e.enabled || (e.mouseEntered = !0);
  }
  function f() {
    !e.enabled || (e.mouseEntered = !1);
  }
  function d(p) {
    return (e.params.mousewheel.thresholdDelta &&
      p.delta < e.params.mousewheel.thresholdDelta) ||
      (e.params.mousewheel.thresholdTime &&
        qe() - l < e.params.mousewheel.thresholdTime)
      ? !1
      : p.delta >= 6 && qe() - l < 60
      ? !0
      : (p.direction < 0
          ? (!e.isEnd || e.params.loop) &&
            !e.animating &&
            (e.slideNext(), r("scroll", p.raw))
          : (!e.isBeginning || e.params.loop) &&
            !e.animating &&
            (e.slidePrev(), r("scroll", p.raw)),
        (l = new i.Date().getTime()),
        !1);
  }
  function v(p) {
    const m = e.params.mousewheel;
    if (p.direction < 0) {
      if (e.isEnd && !e.params.loop && m.releaseOnEdges) return !0;
    } else if (e.isBeginning && !e.params.loop && m.releaseOnEdges) return !0;
    return !1;
  }
  function g(p) {
    let m = p,
      S = !0;
    if (!e.enabled) return;
    const w = e.params.mousewheel;
    e.params.cssMode && m.preventDefault();
    let P = e.$el;
    if (
      (e.params.mousewheel.eventsTarget !== "container" &&
        (P = H(e.params.mousewheel.eventsTarget)),
      !e.mouseEntered && !P[0].contains(m.target) && !w.releaseOnEdges)
    )
      return !0;
    m.originalEvent && (m = m.originalEvent);
    let E = 0;
    const k = e.rtlTranslate ? -1 : 1,
      D = u(m);
    if (w.forceToAxis)
      if (e.isHorizontal())
        if (Math.abs(D.pixelX) > Math.abs(D.pixelY)) E = -D.pixelX * k;
        else return !0;
      else if (Math.abs(D.pixelY) > Math.abs(D.pixelX)) E = -D.pixelY;
      else return !0;
    else
      E = Math.abs(D.pixelX) > Math.abs(D.pixelY) ? -D.pixelX * k : -D.pixelY;
    if (E === 0) return !0;
    w.invert && (E = -E);
    let L = e.getTranslate() + E * w.sensitivity;
    if (
      (L >= e.minTranslate() && (L = e.minTranslate()),
      L <= e.maxTranslate() && (L = e.maxTranslate()),
      (S = e.params.loop
        ? !0
        : !(L === e.minTranslate() || L === e.maxTranslate())),
      S && e.params.nested && m.stopPropagation(),
      !e.params.freeMode || !e.params.freeMode.enabled)
    ) {
      const T = {
        time: qe(),
        delta: Math.abs(E),
        direction: Math.sign(E),
        raw: p,
      };
      s.length >= 2 && s.shift();
      const N = s.length ? s[s.length - 1] : void 0;
      if (
        (s.push(T),
        N
          ? (T.direction !== N.direction ||
              T.delta > N.delta ||
              T.time > N.time + 150) &&
            d(T)
          : d(T),
        v(T))
      )
        return !0;
    } else {
      const T = { time: qe(), delta: Math.abs(E), direction: Math.sign(E) },
        N =
          a &&
          T.time < a.time + 500 &&
          T.delta <= a.delta &&
          T.direction === a.direction;
      if (!N) {
        (a = void 0), e.params.loop && e.loopFix();
        let j = e.getTranslate() + E * w.sensitivity;
        const U = e.isBeginning,
          B = e.isEnd;
        if (
          (j >= e.minTranslate() && (j = e.minTranslate()),
          j <= e.maxTranslate() && (j = e.maxTranslate()),
          e.setTransition(0),
          e.setTranslate(j),
          e.updateProgress(),
          e.updateActiveIndex(),
          e.updateSlidesClasses(),
          ((!U && e.isBeginning) || (!B && e.isEnd)) && e.updateSlidesClasses(),
          e.params.freeMode.sticky)
        ) {
          clearTimeout(o), (o = void 0), s.length >= 15 && s.shift();
          const Z = s.length ? s[s.length - 1] : void 0,
            q = s[0];
          if (
            (s.push(T), Z && (T.delta > Z.delta || T.direction !== Z.direction))
          )
            s.splice(0);
          else if (
            s.length >= 15 &&
            T.time - q.time < 500 &&
            q.delta - T.delta >= 1 &&
            T.delta <= 6
          ) {
            const $ = E > 0 ? 0.8 : 0.2;
            (a = T),
              s.splice(0),
              (o = ar(() => {
                e.slideToClosest(e.params.speed, !0, void 0, $);
              }, 0));
          }
          o ||
            (o = ar(() => {
              (a = T),
                s.splice(0),
                e.slideToClosest(e.params.speed, !0, void 0, 0.5);
            }, 500));
        }
        if (
          (N || r("scroll", m),
          e.params.autoplay &&
            e.params.autoplayDisableOnInteraction &&
            e.autoplay.stop(),
          j === e.minTranslate() || j === e.maxTranslate())
        )
          return !0;
      }
    }
    return m.preventDefault ? m.preventDefault() : (m.returnValue = !1), !1;
  }
  function y(p) {
    let m = e.$el;
    e.params.mousewheel.eventsTarget !== "container" &&
      (m = H(e.params.mousewheel.eventsTarget)),
      m[p]("mouseenter", c),
      m[p]("mouseleave", f),
      m[p]("wheel", g);
  }
  function x() {
    return e.params.cssMode
      ? (e.wrapperEl.removeEventListener("wheel", g), !0)
      : e.mousewheel.enabled
      ? !1
      : (y("on"), (e.mousewheel.enabled = !0), !0);
  }
  function h() {
    return e.params.cssMode
      ? (e.wrapperEl.addEventListener(event, g), !0)
      : e.mousewheel.enabled
      ? (y("off"), (e.mousewheel.enabled = !1), !0)
      : !1;
  }
  n("init", () => {
    !e.params.mousewheel.enabled && e.params.cssMode && h(),
      e.params.mousewheel.enabled && x();
  }),
    n("destroy", () => {
      e.params.cssMode && x(), e.mousewheel.enabled && h();
    }),
    Object.assign(e.mousewheel, { enable: x, disable: h });
}
function Uy(e, t, n, r) {
  const i = He();
  return (
    e.params.createElements &&
      Object.keys(r).forEach((o) => {
        if (!n[o] && n.auto === !0) {
          let l = e.$el.children(`.${r[o]}`)[0];
          l ||
            ((l = i.createElement("div")),
            (l.className = r[o]),
            e.$el.append(l)),
            (n[o] = l),
            (t[o] = l);
        }
      }),
    n
  );
}
function Wy({ swiper: e, extendParams: t, on: n, emit: r }) {
  const i = He();
  let o = !1,
    l = null,
    a = null,
    s,
    u,
    c,
    f;
  t({
    scrollbar: {
      el: null,
      dragSize: "auto",
      hide: !1,
      draggable: !1,
      snapOnRelease: !0,
      lockClass: "swiper-scrollbar-lock",
      dragClass: "swiper-scrollbar-drag",
      scrollbarDisabledClass: "swiper-scrollbar-disabled",
      horizontalClass: "swiper-scrollbar-horizontal",
      verticalClass: "swiper-scrollbar-vertical",
    },
  }),
    (e.scrollbar = { el: null, dragEl: null, $el: null, $dragEl: null });
  function d() {
    if (!e.params.scrollbar.el || !e.scrollbar.el) return;
    const { scrollbar: T, rtlTranslate: N, progress: j } = e,
      { $dragEl: U, $el: B } = T,
      Z = e.params.scrollbar;
    let q = u,
      $ = (c - u) * j;
    N
      ? (($ = -$), $ > 0 ? ((q = u - $), ($ = 0)) : -$ + u > c && (q = c + $))
      : $ < 0
      ? ((q = u + $), ($ = 0))
      : $ + u > c && (q = c - $),
      e.isHorizontal()
        ? (U.transform(`translate3d(${$}px, 0, 0)`),
          (U[0].style.width = `${q}px`))
        : (U.transform(`translate3d(0px, ${$}px, 0)`),
          (U[0].style.height = `${q}px`)),
      Z.hide &&
        (clearTimeout(l),
        (B[0].style.opacity = 1),
        (l = setTimeout(() => {
          (B[0].style.opacity = 0), B.transition(400);
        }, 1e3)));
  }
  function v(T) {
    !e.params.scrollbar.el ||
      !e.scrollbar.el ||
      e.scrollbar.$dragEl.transition(T);
  }
  function g() {
    if (!e.params.scrollbar.el || !e.scrollbar.el) return;
    const { scrollbar: T } = e,
      { $dragEl: N, $el: j } = T;
    (N[0].style.width = ""),
      (N[0].style.height = ""),
      (c = e.isHorizontal() ? j[0].offsetWidth : j[0].offsetHeight),
      (f =
        e.size /
        (e.virtualSize +
          e.params.slidesOffsetBefore -
          (e.params.centeredSlides ? e.snapGrid[0] : 0))),
      e.params.scrollbar.dragSize === "auto"
        ? (u = c * f)
        : (u = parseInt(e.params.scrollbar.dragSize, 10)),
      e.isHorizontal()
        ? (N[0].style.width = `${u}px`)
        : (N[0].style.height = `${u}px`),
      f >= 1 ? (j[0].style.display = "none") : (j[0].style.display = ""),
      e.params.scrollbar.hide && (j[0].style.opacity = 0),
      e.params.watchOverflow &&
        e.enabled &&
        T.$el[e.isLocked ? "addClass" : "removeClass"](
          e.params.scrollbar.lockClass
        );
  }
  function y(T) {
    return e.isHorizontal()
      ? T.type === "touchstart" || T.type === "touchmove"
        ? T.targetTouches[0].clientX
        : T.clientX
      : T.type === "touchstart" || T.type === "touchmove"
      ? T.targetTouches[0].clientY
      : T.clientY;
  }
  function x(T) {
    const { scrollbar: N, rtlTranslate: j } = e,
      { $el: U } = N;
    let B;
    (B =
      (y(T) -
        U.offset()[e.isHorizontal() ? "left" : "top"] -
        (s !== null ? s : u / 2)) /
      (c - u)),
      (B = Math.max(Math.min(B, 1), 0)),
      j && (B = 1 - B);
    const Z = e.minTranslate() + (e.maxTranslate() - e.minTranslate()) * B;
    e.updateProgress(Z),
      e.setTranslate(Z),
      e.updateActiveIndex(),
      e.updateSlidesClasses();
  }
  function h(T) {
    const N = e.params.scrollbar,
      { scrollbar: j, $wrapperEl: U } = e,
      { $el: B, $dragEl: Z } = j;
    (o = !0),
      (s =
        T.target === Z[0] || T.target === Z
          ? y(T) -
            T.target.getBoundingClientRect()[e.isHorizontal() ? "left" : "top"]
          : null),
      T.preventDefault(),
      T.stopPropagation(),
      U.transition(100),
      Z.transition(100),
      x(T),
      clearTimeout(a),
      B.transition(0),
      N.hide && B.css("opacity", 1),
      e.params.cssMode && e.$wrapperEl.css("scroll-snap-type", "none"),
      r("scrollbarDragStart", T);
  }
  function p(T) {
    const { scrollbar: N, $wrapperEl: j } = e,
      { $el: U, $dragEl: B } = N;
    !o ||
      (T.preventDefault ? T.preventDefault() : (T.returnValue = !1),
      x(T),
      j.transition(0),
      U.transition(0),
      B.transition(0),
      r("scrollbarDragMove", T));
  }
  function m(T) {
    const N = e.params.scrollbar,
      { scrollbar: j, $wrapperEl: U } = e,
      { $el: B } = j;
    !o ||
      ((o = !1),
      e.params.cssMode &&
        (e.$wrapperEl.css("scroll-snap-type", ""), U.transition("")),
      N.hide &&
        (clearTimeout(a),
        (a = ar(() => {
          B.css("opacity", 0), B.transition(400);
        }, 1e3))),
      r("scrollbarDragEnd", T),
      N.snapOnRelease && e.slideToClosest());
  }
  function S(T) {
    const {
        scrollbar: N,
        touchEventsTouch: j,
        touchEventsDesktop: U,
        params: B,
        support: Z,
      } = e,
      q = N.$el;
    if (!q) return;
    const $ = q[0],
      O =
        Z.passiveListener && B.passiveListeners
          ? { passive: !1, capture: !1 }
          : !1,
      M =
        Z.passiveListener && B.passiveListeners
          ? { passive: !0, capture: !1 }
          : !1;
    if (!$) return;
    const F = T === "on" ? "addEventListener" : "removeEventListener";
    Z.touch
      ? ($[F](j.start, h, O), $[F](j.move, p, O), $[F](j.end, m, M))
      : ($[F](U.start, h, O), i[F](U.move, p, O), i[F](U.end, m, M));
  }
  function w() {
    !e.params.scrollbar.el || !e.scrollbar.el || S("on");
  }
  function P() {
    !e.params.scrollbar.el || !e.scrollbar.el || S("off");
  }
  function E() {
    const { scrollbar: T, $el: N } = e;
    e.params.scrollbar = Uy(e, e.originalParams.scrollbar, e.params.scrollbar, {
      el: "swiper-scrollbar",
    });
    const j = e.params.scrollbar;
    if (!j.el) return;
    let U = H(j.el);
    e.params.uniqueNavElements &&
      typeof j.el == "string" &&
      U.length > 1 &&
      N.find(j.el).length === 1 &&
      (U = N.find(j.el)),
      U.addClass(e.isHorizontal() ? j.horizontalClass : j.verticalClass);
    let B = U.find(`.${e.params.scrollbar.dragClass}`);
    B.length === 0 &&
      ((B = H(`<div class="${e.params.scrollbar.dragClass}"></div>`)),
      U.append(B)),
      Object.assign(T, { $el: U, el: U[0], $dragEl: B, dragEl: B[0] }),
      j.draggable && w(),
      U &&
        U[e.enabled ? "removeClass" : "addClass"](e.params.scrollbar.lockClass);
  }
  function k() {
    const T = e.params.scrollbar,
      N = e.scrollbar.$el;
    N && N.removeClass(e.isHorizontal() ? T.horizontalClass : T.verticalClass),
      P();
  }
  n("init", () => {
    e.params.scrollbar.enabled === !1 ? L() : (E(), g(), d());
  }),
    n("update resize observerUpdate lock unlock", () => {
      g();
    }),
    n("setTranslate", () => {
      d();
    }),
    n("setTransition", (T, N) => {
      v(N);
    }),
    n("enable disable", () => {
      const { $el: T } = e.scrollbar;
      T &&
        T[e.enabled ? "removeClass" : "addClass"](e.params.scrollbar.lockClass);
    }),
    n("destroy", () => {
      k();
    });
  const D = () => {
      e.$el.removeClass(e.params.scrollbar.scrollbarDisabledClass),
        e.scrollbar.$el &&
          e.scrollbar.$el.removeClass(
            e.params.scrollbar.scrollbarDisabledClass
          ),
        E(),
        g(),
        d();
    },
    L = () => {
      e.$el.addClass(e.params.scrollbar.scrollbarDisabledClass),
        e.scrollbar.$el &&
          e.scrollbar.$el.addClass(e.params.scrollbar.scrollbarDisabledClass),
        k();
    };
  Object.assign(e.scrollbar, {
    enable: D,
    disable: L,
    updateSize: g,
    setTranslate: d,
    init: E,
    destroy: k,
  });
}
function Gy({ swiper: e, extendParams: t, emit: n, once: r }) {
  t({
    freeMode: {
      enabled: !1,
      momentum: !0,
      momentumRatio: 1,
      momentumBounce: !0,
      momentumBounceRatio: 1,
      momentumVelocityRatio: 1,
      sticky: !1,
      minimumVelocity: 0.02,
    },
  });
  function i() {
    const a = e.getTranslate();
    e.setTranslate(a),
      e.setTransition(0),
      (e.touchEventsData.velocities.length = 0),
      e.freeMode.onTouchEnd({ currentPos: e.rtl ? e.translate : -e.translate });
  }
  function o() {
    const { touchEventsData: a, touches: s } = e;
    a.velocities.length === 0 &&
      a.velocities.push({
        position: s[e.isHorizontal() ? "startX" : "startY"],
        time: a.touchStartTime,
      }),
      a.velocities.push({
        position: s[e.isHorizontal() ? "currentX" : "currentY"],
        time: qe(),
      });
  }
  function l({ currentPos: a }) {
    const {
        params: s,
        $wrapperEl: u,
        rtlTranslate: c,
        snapGrid: f,
        touchEventsData: d,
      } = e,
      g = qe() - d.touchStartTime;
    if (a < -e.minTranslate()) {
      e.slideTo(e.activeIndex);
      return;
    }
    if (a > -e.maxTranslate()) {
      e.slides.length < f.length
        ? e.slideTo(f.length - 1)
        : e.slideTo(e.slides.length - 1);
      return;
    }
    if (s.freeMode.momentum) {
      if (d.velocities.length > 1) {
        const P = d.velocities.pop(),
          E = d.velocities.pop(),
          k = P.position - E.position,
          D = P.time - E.time;
        (e.velocity = k / D),
          (e.velocity /= 2),
          Math.abs(e.velocity) < s.freeMode.minimumVelocity && (e.velocity = 0),
          (D > 150 || qe() - P.time > 300) && (e.velocity = 0);
      } else e.velocity = 0;
      (e.velocity *= s.freeMode.momentumVelocityRatio),
        (d.velocities.length = 0);
      let y = 1e3 * s.freeMode.momentumRatio;
      const x = e.velocity * y;
      let h = e.translate + x;
      c && (h = -h);
      let p = !1,
        m;
      const S = Math.abs(e.velocity) * 20 * s.freeMode.momentumBounceRatio;
      let w;
      if (h < e.maxTranslate())
        s.freeMode.momentumBounce
          ? (h + e.maxTranslate() < -S && (h = e.maxTranslate() - S),
            (m = e.maxTranslate()),
            (p = !0),
            (d.allowMomentumBounce = !0))
          : (h = e.maxTranslate()),
          s.loop && s.centeredSlides && (w = !0);
      else if (h > e.minTranslate())
        s.freeMode.momentumBounce
          ? (h - e.minTranslate() > S && (h = e.minTranslate() + S),
            (m = e.minTranslate()),
            (p = !0),
            (d.allowMomentumBounce = !0))
          : (h = e.minTranslate()),
          s.loop && s.centeredSlides && (w = !0);
      else if (s.freeMode.sticky) {
        let P;
        for (let E = 0; E < f.length; E += 1)
          if (f[E] > -h) {
            P = E;
            break;
          }
        Math.abs(f[P] - h) < Math.abs(f[P - 1] - h) ||
        e.swipeDirection === "next"
          ? (h = f[P])
          : (h = f[P - 1]),
          (h = -h);
      }
      if (
        (w &&
          r("transitionEnd", () => {
            e.loopFix();
          }),
        e.velocity !== 0)
      ) {
        if (
          (c
            ? (y = Math.abs((-h - e.translate) / e.velocity))
            : (y = Math.abs((h - e.translate) / e.velocity)),
          s.freeMode.sticky)
        ) {
          const P = Math.abs((c ? -h : h) - e.translate),
            E = e.slidesSizesGrid[e.activeIndex];
          P < E
            ? (y = s.speed)
            : P < 2 * E
            ? (y = s.speed * 1.5)
            : (y = s.speed * 2.5);
        }
      } else if (s.freeMode.sticky) {
        e.slideToClosest();
        return;
      }
      s.freeMode.momentumBounce && p
        ? (e.updateProgress(m),
          e.setTransition(y),
          e.setTranslate(h),
          e.transitionStart(!0, e.swipeDirection),
          (e.animating = !0),
          u.transitionEnd(() => {
            !e ||
              e.destroyed ||
              !d.allowMomentumBounce ||
              (n("momentumBounce"),
              e.setTransition(s.speed),
              setTimeout(() => {
                e.setTranslate(m),
                  u.transitionEnd(() => {
                    !e || e.destroyed || e.transitionEnd();
                  });
              }, 0));
          }))
        : e.velocity
        ? (n("_freeModeNoMomentumRelease"),
          e.updateProgress(h),
          e.setTransition(y),
          e.setTranslate(h),
          e.transitionStart(!0, e.swipeDirection),
          e.animating ||
            ((e.animating = !0),
            u.transitionEnd(() => {
              !e || e.destroyed || e.transitionEnd();
            })))
        : e.updateProgress(h),
        e.updateActiveIndex(),
        e.updateSlidesClasses();
    } else if (s.freeMode.sticky) {
      e.slideToClosest();
      return;
    } else s.freeMode && n("_freeModeNoMomentumRelease");
    (!s.freeMode.momentum || g >= s.longSwipesMs) &&
      (e.updateProgress(), e.updateActiveIndex(), e.updateSlidesClasses());
  }
  Object.assign(e, {
    freeMode: { onTouchStart: i, onTouchMove: o, onTouchEnd: l },
  });
}
function Tn(e) {
  return (
    typeof e == "object" &&
    e !== null &&
    e.constructor &&
    Object.prototype.toString.call(e).slice(8, -1) === "Object"
  );
}
function Gt(e, t) {
  const n = ["__proto__", "constructor", "prototype"];
  Object.keys(t)
    .filter((r) => n.indexOf(r) < 0)
    .forEach((r) => {
      typeof e[r] == "undefined"
        ? (e[r] = t[r])
        : Tn(t[r]) && Tn(e[r]) && Object.keys(t[r]).length > 0
        ? t[r].__swiper__
          ? (e[r] = t[r])
          : Gt(e[r], t[r])
        : (e[r] = t[r]);
    });
}
function Gp(e = {}) {
  return (
    e.navigation &&
    typeof e.navigation.nextEl == "undefined" &&
    typeof e.navigation.prevEl == "undefined"
  );
}
function Yp(e = {}) {
  return e.pagination && typeof e.pagination.el == "undefined";
}
function Xp(e = {}) {
  return e.scrollbar && typeof e.scrollbar.el == "undefined";
}
function Qp(e = "") {
  const t = e
      .split(" ")
      .map((r) => r.trim())
      .filter((r) => !!r),
    n = [];
  return (
    t.forEach((r) => {
      n.indexOf(r) < 0 && n.push(r);
    }),
    n.join(" ")
  );
}
const Kp = [
  "modules",
  "init",
  "_direction",
  "touchEventsTarget",
  "initialSlide",
  "_speed",
  "cssMode",
  "updateOnWindowResize",
  "resizeObserver",
  "nested",
  "focusableElements",
  "_enabled",
  "_width",
  "_height",
  "preventInteractionOnTransition",
  "userAgent",
  "url",
  "_edgeSwipeDetection",
  "_edgeSwipeThreshold",
  "_freeMode",
  "_autoHeight",
  "setWrapperSize",
  "virtualTranslate",
  "_effect",
  "breakpoints",
  "_spaceBetween",
  "_slidesPerView",
  "maxBackfaceHiddenSlides",
  "_grid",
  "_slidesPerGroup",
  "_slidesPerGroupSkip",
  "_slidesPerGroupAuto",
  "_centeredSlides",
  "_centeredSlidesBounds",
  "_slidesOffsetBefore",
  "_slidesOffsetAfter",
  "normalizeSlideIndex",
  "_centerInsufficientSlides",
  "_watchOverflow",
  "roundLengths",
  "touchRatio",
  "touchAngle",
  "simulateTouch",
  "_shortSwipes",
  "_longSwipes",
  "longSwipesRatio",
  "longSwipesMs",
  "_followFinger",
  "allowTouchMove",
  "_threshold",
  "touchMoveStopPropagation",
  "touchStartPreventDefault",
  "touchStartForcePreventDefault",
  "touchReleaseOnEdges",
  "uniqueNavElements",
  "_resistance",
  "_resistanceRatio",
  "_watchSlidesProgress",
  "_grabCursor",
  "preventClicks",
  "preventClicksPropagation",
  "_slideToClickedSlide",
  "_preloadImages",
  "updateOnImagesReady",
  "_loop",
  "_loopAdditionalSlides",
  "_loopedSlides",
  "_loopedSlidesLimit",
  "_loopFillGroupWithBlank",
  "loopPreventsSlide",
  "_rewind",
  "_allowSlidePrev",
  "_allowSlideNext",
  "_swipeHandler",
  "_noSwiping",
  "noSwipingClass",
  "noSwipingSelector",
  "passiveListeners",
  "containerModifierClass",
  "slideClass",
  "slideBlankClass",
  "slideActiveClass",
  "slideDuplicateActiveClass",
  "slideVisibleClass",
  "slideDuplicateClass",
  "slideNextClass",
  "slideDuplicateNextClass",
  "slidePrevClass",
  "slideDuplicatePrevClass",
  "wrapperClass",
  "runCallbacksOnInit",
  "observer",
  "observeParents",
  "observeSlideChildren",
  "a11y",
  "_autoplay",
  "_controller",
  "coverflowEffect",
  "cubeEffect",
  "fadeEffect",
  "flipEffect",
  "creativeEffect",
  "cardsEffect",
  "hashNavigation",
  "history",
  "keyboard",
  "lazy",
  "mousewheel",
  "_navigation",
  "_pagination",
  "parallax",
  "_scrollbar",
  "_thumbs",
  "virtual",
  "zoom",
];
function Yy(e = {}, t = !0) {
  const n = { on: {} },
    r = {},
    i = {};
  Gt(n, je.defaults),
    Gt(n, je.extendedDefaults),
    (n._emitClasses = !0),
    (n.init = !1);
  const o = {},
    l = Kp.map((s) => s.replace(/_/, "")),
    a = Object.assign({}, e);
  return (
    Object.keys(a).forEach((s) => {
      typeof e[s] != "undefined" &&
        (l.indexOf(s) >= 0
          ? Tn(e[s])
            ? ((n[s] = {}), (i[s] = {}), Gt(n[s], e[s]), Gt(i[s], e[s]))
            : ((n[s] = e[s]), (i[s] = e[s]))
          : s.search(/on[A-Z]/) === 0 && typeof e[s] == "function"
          ? t
            ? (r[`${s[2].toLowerCase()}${s.substr(3)}`] = e[s])
            : (n.on[`${s[2].toLowerCase()}${s.substr(3)}`] = e[s])
          : (o[s] = e[s]));
    }),
    ["navigation", "pagination", "scrollbar"].forEach((s) => {
      n[s] === !0 && (n[s] = {}), n[s] === !1 && delete n[s];
    }),
    { params: n, passedParams: i, rest: o, events: r }
  );
}
function Xy(
  { el: e, nextEl: t, prevEl: n, paginationEl: r, scrollbarEl: i, swiper: o },
  l
) {
  Gp(l) &&
    t &&
    n &&
    ((o.params.navigation.nextEl = t),
    (o.originalParams.navigation.nextEl = t),
    (o.params.navigation.prevEl = n),
    (o.originalParams.navigation.prevEl = n)),
    Yp(l) &&
      r &&
      ((o.params.pagination.el = r), (o.originalParams.pagination.el = r)),
    Xp(l) &&
      i &&
      ((o.params.scrollbar.el = i), (o.originalParams.scrollbar.el = i)),
    o.init(e);
}
const Zp = (e, t) => {
  let n = t.slidesPerView;
  if (t.breakpoints) {
    const i = je.prototype.getBreakpoint(t.breakpoints),
      o = i in t.breakpoints ? t.breakpoints[i] : void 0;
    o && o.slidesPerView && (n = o.slidesPerView);
  }
  let r = Math.ceil(parseFloat(t.loopedSlides || n, 10));
  return (
    (r += t.loopAdditionalSlides),
    r > e.length && t.loopedSlidesLimit && (r = e.length),
    r
  );
};
function Qy(e, t, n) {
  const r = t.map((s, u) =>
    Q.cloneElement(s, { swiper: e, "data-swiper-slide-index": u })
  );
  function i(s, u, c) {
    return Q.cloneElement(s, {
      key: `${s.key}-duplicate-${u}-${c}`,
      className: `${s.props.className || ""} ${n.slideDuplicateClass}`,
    });
  }
  if (n.loopFillGroupWithBlank) {
    const s = n.slidesPerGroup - (r.length % n.slidesPerGroup);
    if (s !== n.slidesPerGroup)
      for (let u = 0; u < s; u += 1) {
        const c = Q.createElement("div", {
          className: `${n.slideClass} ${n.slideBlankClass}`,
        });
        r.push(c);
      }
  }
  n.slidesPerView === "auto" && !n.loopedSlides && (n.loopedSlides = r.length);
  const o = Zp(r, n),
    l = [],
    a = [];
  for (let s = 0; s < o; s += 1) {
    const u = s - Math.floor(s / r.length) * r.length;
    a.push(i(r[u], s, "append")),
      l.unshift(i(r[r.length - u - 1], s, "prepend"));
  }
  return e && (e.loopedSlides = o), [...l, ...r, ...a];
}
function Ky(e, t, n, r, i) {
  const o = [];
  if (!t) return o;
  const l = (s) => {
    o.indexOf(s) < 0 && o.push(s);
  };
  if (n && r) {
    const s = r.map(i),
      u = n.map(i);
    s.join("") !== u.join("") && l("children"),
      r.length !== n.length && l("children");
  }
  return (
    Kp.filter((s) => s[0] === "_")
      .map((s) => s.replace(/_/, ""))
      .forEach((s) => {
        if (s in e && s in t)
          if (Tn(e[s]) && Tn(t[s])) {
            const u = Object.keys(e[s]),
              c = Object.keys(t[s]);
            u.length !== c.length
              ? l(s)
              : (u.forEach((f) => {
                  e[s][f] !== t[s][f] && l(s);
                }),
                c.forEach((f) => {
                  e[s][f] !== t[s][f] && l(s);
                }));
          } else e[s] !== t[s] && l(s);
      }),
    o
  );
}
function qp(e) {
  return (
    e.type && e.type.displayName && e.type.displayName.includes("SwiperSlide")
  );
}
function Jp(e) {
  const t = [];
  return (
    Q.Children.toArray(e).forEach((n) => {
      qp(n)
        ? t.push(n)
        : n.props &&
          n.props.children &&
          Jp(n.props.children).forEach((r) => t.push(r));
    }),
    t
  );
}
function Zy(e) {
  const t = [],
    n = {
      "container-start": [],
      "container-end": [],
      "wrapper-start": [],
      "wrapper-end": [],
    };
  return (
    Q.Children.toArray(e).forEach((r) => {
      if (qp(r)) t.push(r);
      else if (r.props && r.props.slot && n[r.props.slot])
        n[r.props.slot].push(r);
      else if (r.props && r.props.children) {
        const i = Jp(r.props.children);
        i.length > 0 ? i.forEach((o) => t.push(o)) : n["container-end"].push(r);
      } else n["container-end"].push(r);
    }),
    { slides: t, slots: n }
  );
}
function qy({
  swiper: e,
  slides: t,
  passedParams: n,
  changedParams: r,
  nextEl: i,
  prevEl: o,
  scrollbarEl: l,
  paginationEl: a,
}) {
  const s = r.filter((w) => w !== "children" && w !== "direction"),
    {
      params: u,
      pagination: c,
      navigation: f,
      scrollbar: d,
      virtual: v,
      thumbs: g,
    } = e;
  let y, x, h, p, m;
  r.includes("thumbs") &&
    n.thumbs &&
    n.thumbs.swiper &&
    u.thumbs &&
    !u.thumbs.swiper &&
    (y = !0),
    r.includes("controller") &&
      n.controller &&
      n.controller.control &&
      u.controller &&
      !u.controller.control &&
      (x = !0),
    r.includes("pagination") &&
      n.pagination &&
      (n.pagination.el || a) &&
      (u.pagination || u.pagination === !1) &&
      c &&
      !c.el &&
      (h = !0),
    r.includes("scrollbar") &&
      n.scrollbar &&
      (n.scrollbar.el || l) &&
      (u.scrollbar || u.scrollbar === !1) &&
      d &&
      !d.el &&
      (p = !0),
    r.includes("navigation") &&
      n.navigation &&
      (n.navigation.prevEl || o) &&
      (n.navigation.nextEl || i) &&
      (u.navigation || u.navigation === !1) &&
      f &&
      !f.prevEl &&
      !f.nextEl &&
      (m = !0);
  const S = (w) => {
    !e[w] ||
      (e[w].destroy(),
      w === "navigation"
        ? ((u[w].prevEl = void 0),
          (u[w].nextEl = void 0),
          (e[w].prevEl = void 0),
          (e[w].nextEl = void 0))
        : ((u[w].el = void 0), (e[w].el = void 0)));
  };
  s.forEach((w) => {
    if (Tn(u[w]) && Tn(n[w])) Gt(u[w], n[w]);
    else {
      const P = n[w];
      (P === !0 || P === !1) &&
      (w === "navigation" || w === "pagination" || w === "scrollbar")
        ? P === !1 && S(w)
        : (u[w] = n[w]);
    }
  }),
    s.includes("controller") &&
      !x &&
      e.controller &&
      e.controller.control &&
      u.controller &&
      u.controller.control &&
      (e.controller.control = u.controller.control),
    r.includes("children") && t && v && u.virtual.enabled
      ? ((v.slides = t), v.update(!0))
      : r.includes("children") &&
        e.lazy &&
        e.params.lazy.enabled &&
        e.lazy.load(),
    y && g.init() && g.update(!0),
    x && (e.controller.control = u.controller.control),
    h && (a && (u.pagination.el = a), c.init(), c.render(), c.update()),
    p &&
      (l && (u.scrollbar.el = l), d.init(), d.updateSize(), d.setTranslate()),
    m &&
      (i && (u.navigation.nextEl = i),
      o && (u.navigation.prevEl = o),
      f.init(),
      f.update()),
    r.includes("allowSlideNext") && (e.allowSlideNext = n.allowSlideNext),
    r.includes("allowSlidePrev") && (e.allowSlidePrev = n.allowSlidePrev),
    r.includes("direction") && e.changeDirection(n.direction, !1),
    e.update();
}
function Jy(e, t, n) {
  if (!n) return null;
  const r = e.isHorizontal()
    ? { [e.rtlTranslate ? "right" : "left"]: `${n.offset}px` }
    : { top: `${n.offset}px` };
  return t
    .filter((i, o) => o >= n.from && o <= n.to)
    .map((i) => Q.cloneElement(i, { swiper: e, style: r }));
}
const eS = (e) => {
  !e ||
    e.destroyed ||
    !e.params.virtual ||
    (e.params.virtual && !e.params.virtual.enabled) ||
    (e.updateSlides(),
    e.updateProgress(),
    e.updateSlidesClasses(),
    e.lazy && e.params.lazy.enabled && e.lazy.load(),
    e.parallax &&
      e.params.parallax &&
      e.params.parallax.enabled &&
      e.parallax.setTranslate());
};
function Br(e, t) {
  return typeof window == "undefined"
    ? A.exports.useEffect(e, t)
    : A.exports.useLayoutEffect(e, t);
}
const tS = A.exports.createContext(null),
  nS = A.exports.createContext(null),
  eh = A.exports.forwardRef(function (e, t) {
    let {
        className: n,
        tag: r = "div",
        wrapperTag: i = "div",
        children: o,
        onSwiper: l,
        ...a
      } = e === void 0 ? {} : e,
      s = !1;
    const [u, c] = A.exports.useState("swiper"),
      [f, d] = A.exports.useState(null),
      [v, g] = A.exports.useState(!1),
      y = A.exports.useRef(!1),
      x = A.exports.useRef(null),
      h = A.exports.useRef(null),
      p = A.exports.useRef(null),
      m = A.exports.useRef(null),
      S = A.exports.useRef(null),
      w = A.exports.useRef(null),
      P = A.exports.useRef(null),
      E = A.exports.useRef(null),
      { params: k, passedParams: D, rest: L, events: T } = Yy(a),
      { slides: N, slots: j } = Zy(o),
      U = () => {
        g(!v);
      };
    Object.assign(k.on, {
      _containerClasses(O, M) {
        c(M);
      },
    });
    const B = () => {
      if (
        (Object.assign(k.on, T),
        (s = !0),
        (h.current = new je(k)),
        (h.current.loopCreate = () => {}),
        (h.current.loopDestroy = () => {}),
        k.loop && (h.current.loopedSlides = Zp(N, k)),
        h.current.virtual && h.current.params.virtual.enabled)
      ) {
        h.current.virtual.slides = N;
        const O = {
          cache: !1,
          slides: N,
          renderExternal: d,
          renderExternalUpdate: !1,
        };
        Gt(h.current.params.virtual, O),
          Gt(h.current.originalParams.virtual, O);
      }
    };
    x.current || B(), h.current && h.current.on("_beforeBreakpoint", U);
    const Z = () => {
        s ||
          !T ||
          !h.current ||
          Object.keys(T).forEach((O) => {
            h.current.on(O, T[O]);
          });
      },
      q = () => {
        !T ||
          !h.current ||
          Object.keys(T).forEach((O) => {
            h.current.off(O, T[O]);
          });
      };
    A.exports.useEffect(() => () => {
      h.current && h.current.off("_beforeBreakpoint", U);
    }),
      A.exports.useEffect(() => {
        !y.current &&
          h.current &&
          (h.current.emitSlidesClasses(), (y.current = !0));
      }),
      Br(() => {
        if ((t && (t.current = x.current), !!x.current))
          return (
            h.current.destroyed && B(),
            Xy(
              {
                el: x.current,
                nextEl: S.current,
                prevEl: w.current,
                paginationEl: P.current,
                scrollbarEl: E.current,
                swiper: h.current,
              },
              k
            ),
            l && l(h.current),
            () => {
              h.current && !h.current.destroyed && h.current.destroy(!0, !1);
            }
          );
      }, []),
      Br(() => {
        Z();
        const O = Ky(D, p.current, N, m.current, (M) => M.key);
        return (
          (p.current = D),
          (m.current = N),
          O.length &&
            h.current &&
            !h.current.destroyed &&
            qy({
              swiper: h.current,
              slides: N,
              passedParams: D,
              changedParams: O,
              nextEl: S.current,
              prevEl: w.current,
              scrollbarEl: E.current,
              paginationEl: P.current,
            }),
          () => {
            q();
          }
        );
      }),
      Br(() => {
        eS(h.current);
      }, [f]);
    function $() {
      return k.virtual
        ? Jy(h.current, N, f)
        : !k.loop || (h.current && h.current.destroyed)
        ? N.map((O) => Q.cloneElement(O, { swiper: h.current }))
        : Qy(h.current, N, k);
    }
    return G(r, {
      ref: x,
      className: Qp(`${u}${n ? ` ${n}` : ""}`),
      ...L,
      children: Te(nS.Provider, {
        value: h.current,
        children: [
          j["container-start"],
          Te(i, {
            className: "swiper-wrapper",
            children: [j["wrapper-start"], $(), j["wrapper-end"]],
          }),
          Gp(k) &&
            Te(li, {
              children: [
                G("div", { ref: w, className: "swiper-button-prev" }),
                G("div", { ref: S, className: "swiper-button-next" }),
              ],
            }),
          Xp(k) && G("div", { ref: E, className: "swiper-scrollbar" }),
          Yp(k) && G("div", { ref: P, className: "swiper-pagination" }),
          j["container-end"],
        ],
      }),
    });
  });
eh.displayName = "Swiper";
const th = A.exports.forwardRef(function (e, t) {
  let {
    tag: n = "div",
    children: r,
    className: i = "",
    swiper: o,
    zoom: l,
    virtualIndex: a,
    ...s
  } = e === void 0 ? {} : e;
  const u = A.exports.useRef(null),
    [c, f] = A.exports.useState("swiper-slide");
  function d(y, x, h) {
    x === u.current && f(h);
  }
  Br(() => {
    if ((t && (t.current = u.current), !(!u.current || !o))) {
      if (o.destroyed) {
        c !== "swiper-slide" && f("swiper-slide");
        return;
      }
      return (
        o.on("_slideClass", d),
        () => {
          !o || o.off("_slideClass", d);
        }
      );
    }
  }),
    Br(() => {
      o && u.current && !o.destroyed && f(o.getSlideClasses(u.current));
    }, [o]);
  const v = {
      isActive:
        c.indexOf("swiper-slide-active") >= 0 ||
        c.indexOf("swiper-slide-duplicate-active") >= 0,
      isVisible: c.indexOf("swiper-slide-visible") >= 0,
      isDuplicate: c.indexOf("swiper-slide-duplicate") >= 0,
      isPrev:
        c.indexOf("swiper-slide-prev") >= 0 ||
        c.indexOf("swiper-slide-duplicate-prev") >= 0,
      isNext:
        c.indexOf("swiper-slide-next") >= 0 ||
        c.indexOf("swiper-slide-duplicate-next") >= 0,
    },
    g = () => (typeof r == "function" ? r(v) : r);
  return G(n, {
    ref: u,
    className: Qp(`${c}${i ? ` ${i}` : ""}`),
    "data-swiper-slide-index": a,
    ...s,
    children: G(tS.Provider, {
      value: v,
      children: l
        ? G("div", {
            className: "swiper-zoom-container",
            "data-swiper-zoom": typeof l == "number" ? l : void 0,
            children: g(),
          })
        : g(),
    }),
  });
});
th.displayName = "SwiperSlide";
const rS = me(eh)` 
    width: 100%; 

    background: ${({ theme: e }) => e.COLORS.BLACK_55};

    padding: 1.5rem 1.25rem;

    list-style-type: none;

    .swiper-slide {
        display: flex; 
        flex-direction: column; 
        gap: 0.625rem;   
    }
    
    .scrollVehicle {
        overflow: auto;
        display: flex;
        flex-direction: column;
        height: max-content;
        min-height: 42rem;
        
        ::-webkit-scrollbar {
            display: none;
        }
    }

    overflow: hidden;
`,
  iS = me(th)` 
`,
  oS = (e) =>
    A.exports.createElement(
      "svg",
      {
        viewBox: "0 0 17 16",
        fill: "none",
        xmlns: "http://www.w3.org/2000/svg",
        ...e,
      },
      A.exports.createElement("path", {
        d: "M7.26566 2.93332C8.08631 2.14977 9.21025 1.66666 10.45 1.66666C12.9629 1.66666 15 3.65153 15 6.09999C15 7.30797 14.5042 8.40311 13.7 9.20272M11.1 9.89999C11.1 12.3485 9.0629 14.3333 6.55 14.3333C4.0371 14.3333 2 12.3485 2 9.89999C2 7.45153 4.0371 5.46666 6.55 5.46666C9.0629 5.46666 11.1 7.45153 11.1 9.89999Z",
        strokeLinecap: "round",
        strokeLinejoin: "round",
      })
    ),
  lS = (e) =>
    A.exports.createElement(
      "svg",
      {
        viewBox: "0 0 17 16",
        fill: "none",
        xmlns: "http://www.w3.org/2000/svg",
        ...e,
      },
      A.exports.createElement("path", {
        d: "M7.85 1.66666L9.8 3.56666M9.8 3.56666L7.85 5.46666M9.8 3.56666H5.12C4.0279 3.56666 3.48185 3.56666 3.06472 3.77374C2.6978 3.9559 2.39949 4.24657 2.21254 4.60407C2 5.01051 2 5.54256 2 6.60666V10.2167C2 10.5108 2 10.6579 2.01668 10.7813C2.13188 11.6339 2.82044 12.3048 3.69547 12.4171C3.82219 12.4333 3.97313 12.4333 4.275 12.4333M7.2 12.4333H11.88C12.9721 12.4333 13.5182 12.4333 13.9353 12.2262C14.3022 12.0441 14.6005 11.7534 14.7875 11.3959C15 10.9895 15 10.4574 15 9.39332V5.78332C15 5.48919 15 5.34212 14.9833 5.21866C14.8681 4.36606 14.1796 3.69516 13.3045 3.58291C13.1778 3.56666 13.0269 3.56666 12.725 3.56666M7.2 12.4333L9.15 14.3333M7.2 12.4333L9.15 10.5333",
        strokeLinecap: "round",
        strokeLinejoin: "round",
      })
    ),
  sS = (e) =>
    A.exports.createElement(
      "svg",
      {
        viewBox: "0 0 16 16",
        fill: "none",
        xmlns: "http://www.w3.org/2000/svg",
        ...e,
      },
      A.exports.createElement("path", {
        d: "M4.1 7.36667V9.9M11.9 6.1V8.63333M11.25 2.93333C12.8417 2.93333 13.7025 3.17068 14.1309 3.35478C14.1879 3.3793 14.2164 3.39156 14.2988 3.4681C14.3481 3.51399 14.4382 3.64862 14.4613 3.71112C14.5 3.8154 14.5 3.8724 14.5 3.9864V10.7937C14.5 11.3693 14.5 11.6571 14.4114 11.805C14.3213 11.9554 14.2344 12.0254 14.0658 12.0832C13.9 12.1401 13.5653 12.0774 12.8959 11.9521C12.4274 11.8644 11.8717 11.8 11.25 11.8C9.3 11.8 7.35 13.0667 4.75 13.0667C3.15834 13.0667 2.29746 12.8293 1.86912 12.6452C1.81208 12.6207 1.78356 12.6084 1.70124 12.5319C1.6519 12.486 1.56183 12.3514 1.53866 12.2889C1.5 12.1846 1.5 12.1276 1.5 12.0136L1.5 5.20628C1.5 4.63072 1.5 4.34295 1.58858 4.19503C1.67869 4.04456 1.76558 3.97461 1.93424 3.91678C2.10004 3.85993 2.43472 3.92259 3.10409 4.0479C3.5726 4.13562 4.12826 4.2 4.75 4.2C6.7 4.2 8.65 2.93333 11.25 2.93333ZM9.625 8C9.625 8.87445 8.89746 9.58333 8 9.58333C7.10254 9.58333 6.375 8.87445 6.375 8C6.375 7.12555 7.10254 6.41667 8 6.41667C8.89746 6.41667 9.625 7.12555 9.625 8Z",
        strokeLinecap: "round",
        strokeLinejoin: "round",
      })
    ),
  aS = me.button` 
    width: 2.375rem;
    height: 2.375rem;
    position: relative; 

    display: flex; 
    align-items: center;
    justify-content: center; 

    background: ${(e) =>
      e.city ? "rgba(34, 232, 235, 0.2)" : "rgba(59, 130, 246, 0.2)"};

    padding: 0.6875rem;

    border-radius: 0.325rem;

    svg {
        width: 100%; 
        height: 100%;

        stroke: ${(e) =>
          e.city ? "rgba(34, 232, 235, 0.6)" : "rgba(59, 130, 246, 0.6)"};
    }

    :hover {
        background: ${(e) =>
          e.city ? "rgba(34, 232, 235, 0.4)" : "rgba(59, 130, 246, 0.4)"};

        svg {
            stroke: ${(e) =>
              e.city ? "rgba(34, 232, 235, 1)" : "rgba(59, 130, 246, 1)"};
        }
    }
`,
  uS = m0`
    from { opacity: 0 } 
    to { opacity: 0.5 }
`,
  cS = me.li` 
    width: 30rem; 
    height: 10rem;

    background: ${({ theme: e }) => e.COLORS.BLACK_20};
    border-radius: 0.75rem;

    display: flex; 
    align-items: center; 

    overflow: hidden;

    animation-name: ${uS};
    animation-duration: 300ms; 
    transition: opacity 200ms; 

    ${({ active: e }) => hr` 
        opacity: ${e ? "1" : "0.5"};

        * {
            pointer-events: ${e ? "all" : "none"};
        }
    `}
`,
  fS = me.div`
    width: 13rem;
    padding: 0.2em;
    position: absolute;
    top: 90%;
    left: 90%;
    right: 90%;
    background: rgba(0, 0, 0, 0.8);
    color: white;
    border-radius: 5px 5px 5px 0px;
`;
function Ul({ label: e, type: t, onClick: n, city: r }) {
  const [i, o] = A.exports.useState(!1),
    l = () => {
      o(!0);
    },
    a = () => {
      o(!1);
    };
  let s = G(li, {});
  switch (t) {
    case "sell":
      s = G(sS, {});
      break;
    case "tax":
      s = G(oS, {});
      break;
    case "transfer":
      s = G(lS, {});
      break;
  }
  return Te(aS, {
    onClick: n,
    title: e,
    city: r,
    onMouseEnter: () => l(),
    onMouseLeave: a,
    children: [i ? G(fS, { children: e }) : null, s],
  });
}
const dS = me.div` 
    width: 18rem; 
    height: 100%; 

    padding: 1.25rem 0;

    display: flex; 
    align-items: center; 

    background: ${({ theme: e }) => e.COLORS.BLACK_30};
`,
  // pS = me.img` 
  //   width: 50%; 
  //   height: 100%; 

  //   padding: 0.5rem;

  //   object-fit: contain; 
  // `,
  hS = me.div` 
    max-width: 100%; 
    padding-left: 2.5rem;

    display: flex; 
    flex-direction: column; 
    gap: 0.5rem;
`,
  mS = me.h1` 
    font-family: 'Poppins';
    font-style: normal;
    font-weight: 500;
    font-size: 1.25rem;
    line-height: 1.5rem;

    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 2; /* number of lines to show */
            line-clamp: 2; 
    -webkit-box-orient: vertical;

    color: ${({ theme: e }) => e.COLORS.WHITE};
`,
  vS = me.span` 
    font-family: 'Poppins';
    font-style: normal;
    font-weight: 500;
    font-size: 0.73rem;
    line-height: 1rem;

    color: ${({ theme: e }) => e.COLORS.GRAY_20};

    span.white {
        color: ${({ theme: e }) => e.COLORS.WHITE};
        margin-right: 45px
    }
`,
  gS = me.div` 
    display: flex; 
    align-items: center; 
    gap: 0.5rem;
`;
var yS = "./assets/vehicle-default.49231014.png";
function SS({
  imageURL: e,
  name: t,
  chest: n,
  tax: r,
  onSell: i,
  onTaxBuy: o,
  onTransfer: l,
  city: a,
}) {
  return Te(dS, {
    children: [
      // G(pS, { src: e, onError: ({ target: s }) => (s.src = yS) }),
      Te(hS, {
        children: [
          G(mS, { children: t }),
          Te(vS, {
            children: [
              n != null
                ? Te(li, {
                    children: [
                      "Baú: ",
                      Te("span", { className: "white", children: [n, "kg"] }),
                    ],
                  })
                : null,
              r != null
                ? Te(li, {
                    children: [
                      "Taxa: ",
                      Te("span", { className: "white", children: ["$ ", r] }),
                    ],
                  })
                : null,
            ],
          }),
          Te(gS, {
            children: [
              r != null
                ? G(Ul, {
                    city: a === "hensa",
                    label: "Pagar Taxa",
                    onClick: o,
                    type: "tax",
                  })
                : null,
              r != null
                ? G(Ul, {
                    city: a === "hensa",
                    label: "Vender Veículo",
                    onClick: i,
                    type: "sell",
                  })
                : null,
              r != null
                ? G(Ul, {
                    city: a === "hensa",
                    label: "Transferir Veículo",
                    onClick: l,
                    type: "transfer",
                  })
                : null,
            ],
          }),
        ],
      }),
    ],
  });
}
const wS = "http://127.0.0.1/vehicles/";
var xS = { baseImagesURL: wS };
function kn() {
  return (
    (kn = Object.assign
      ? Object.assign.bind()
      : function (e) {
          for (var t = 1; t < arguments.length; t++) {
            var n = arguments[t];
            for (var r in n)
              Object.prototype.hasOwnProperty.call(n, r) && (e[r] = n[r]);
          }
          return e;
        }),
    kn.apply(this, arguments)
  );
}
function CS(e, t = []) {
  let n = [];
  function r(o, l) {
    const a = A.exports.createContext(l),
      s = n.length;
    n = [...n, l];
    function u(f) {
      const { scope: d, children: v, ...g } = f,
        y = (d == null ? void 0 : d[e][s]) || a,
        x = A.exports.useMemo(() => g, Object.values(g));
      return A.exports.createElement(y.Provider, { value: x }, v);
    }
    function c(f, d) {
      const v = (d == null ? void 0 : d[e][s]) || a,
        g = A.exports.useContext(v);
      if (g) return g;
      if (l !== void 0) return l;
      throw new Error(`\`${f}\` must be used within \`${o}\``);
    }
    return (u.displayName = o + "Provider"), [u, c];
  }
  const i = () => {
    const o = n.map((l) => A.exports.createContext(l));
    return function (a) {
      const s = (a == null ? void 0 : a[e]) || o;
      return A.exports.useMemo(
        () => ({ [`__scope${e}`]: { ...a, [e]: s } }),
        [a, s]
      );
    };
  };
  return (i.scopeName = e), [r, ES(i, ...t)];
}
function ES(...e) {
  const t = e[0];
  if (e.length === 1) return t;
  const n = () => {
    const r = e.map((i) => ({ useScope: i(), scopeName: i.scopeName }));
    return function (o) {
      const l = r.reduce((a, { useScope: s, scopeName: u }) => {
        const f = s(o)[`__scope${u}`];
        return { ...a, ...f };
      }, {});
      return A.exports.useMemo(() => ({ [`__scope${t.scopeName}`]: l }), [l]);
    };
  };
  return (n.scopeName = t.scopeName), n;
}
function TS(e, t) {
  typeof e == "function" ? e(t) : e != null && (e.current = t);
}
function kS(...e) {
  return (t) => e.forEach((n) => TS(n, t));
}
const nh = A.exports.forwardRef((e, t) => {
  const { children: n, ...r } = e,
    i = A.exports.Children.toArray(n),
    o = i.find($S);
  if (o) {
    const l = o.props.children,
      a = i.map((s) =>
        s === o
          ? A.exports.Children.count(l) > 1
            ? A.exports.Children.only(null)
            : A.exports.isValidElement(l)
            ? l.props.children
            : null
          : s
      );
    return A.exports.createElement(
      Gs,
      kn({}, r, { ref: t }),
      A.exports.isValidElement(l) ? A.exports.cloneElement(l, void 0, a) : null
    );
  }
  return A.exports.createElement(Gs, kn({}, r, { ref: t }), n);
});
nh.displayName = "Slot";
const Gs = A.exports.forwardRef((e, t) => {
  const { children: n, ...r } = e;
  return A.exports.isValidElement(n)
    ? A.exports.cloneElement(n, { ..._S(r, n.props), ref: kS(t, n.ref) })
    : A.exports.Children.count(n) > 1
    ? A.exports.Children.only(null)
    : null;
});
Gs.displayName = "SlotClone";
const PS = ({ children: e }) =>
  A.exports.createElement(A.exports.Fragment, null, e);
function $S(e) {
  return A.exports.isValidElement(e) && e.type === PS;
}
function _S(e, t) {
  const n = { ...t };
  for (const r in t) {
    const i = e[r],
      o = t[r];
    /^on[A-Z]/.test(r)
      ? i && o
        ? (n[r] = (...a) => {
            o(...a), i(...a);
          })
        : i && (n[r] = i)
      : r === "style"
      ? (n[r] = { ...i, ...o })
      : r === "className" && (n[r] = [i, o].filter(Boolean).join(" "));
  }
  return { ...e, ...n };
}
const LS = [
    "a",
    "button",
    "div",
    "h2",
    "h3",
    // "img",
    "label",
    "li",
    "nav",
    "ol",
    "p",
    "span",
    "svg",
    "ul",
  ],
  rh = LS.reduce((e, t) => {
    const n = A.exports.forwardRef((r, i) => {
      const { asChild: o, ...l } = r,
        a = o ? nh : t;
      return (
        A.exports.useEffect(() => {
          window[Symbol.for("radix-ui")] = !0;
        }, []),
        A.exports.createElement(a, kn({}, l, { ref: i }))
      );
    });
    return (n.displayName = `Primitive.${t}`), { ...e, [t]: n };
  }, {}),
  ih = "Progress",
  rl = 100,
  [OS, JS] = CS(ih),
  [MS, NS] = OS(ih),
  oh = A.exports.forwardRef((e, t) => {
    const {
        __scopeProgress: n,
        value: r,
        max: i,
        getValueLabel: o = RS,
        ...l
      } = e,
      a = Ys(i) ? i : rl,
      s = sh(r, a) ? r : null,
      u = $o(s) ? o(s, a) : void 0;
    return A.exports.createElement(
      MS,
      { scope: n, value: s, max: a },
      A.exports.createElement(
        rh.div,
        kn(
          {
            "aria-valuemax": a,
            "aria-valuemin": 0,
            "aria-valuenow": $o(s) ? s : void 0,
            "aria-valuetext": u,
            role: "progressbar",
            "data-state": lh(s, a),
            "data-value": s != null ? s : void 0,
            "data-max": a,
          },
          l,
          { ref: t }
        )
      )
    );
  });
oh.propTypes = {
  max(e, t, n) {
    const r = e[t],
      i = String(r);
    return r && !Ys(r) ? new Error(IS(i, n)) : null;
  },
  value(e, t, n) {
    const r = e[t],
      i = String(r),
      o = Ys(e.max) ? e.max : rl;
    return r != null && !sh(r, o) ? new Error(bS(i, n)) : null;
  },
};
const AS = "ProgressIndicator",
  zS = A.exports.forwardRef((e, t) => {
    var n;
    const { __scopeProgress: r, ...i } = e,
      o = NS(AS, r);
    return A.exports.createElement(
      rh.div,
      kn(
        {
          "data-state": lh(o.value, o.max),
          "data-value": (n = o.value) !== null && n !== void 0 ? n : void 0,
          "data-max": o.max,
        },
        i,
        { ref: t }
      )
    );
  });
function RS(e, t) {
  return `${Math.round((e / t) * 100)}%`;
}
function lh(e, t) {
  return e == null ? "indeterminate" : e === t ? "complete" : "loading";
}
function $o(e) {
  return typeof e == "number";
}
function Ys(e) {
  return $o(e) && !isNaN(e) && e > 0;
}
function sh(e, t) {
  return $o(e) && !isNaN(e) && e <= t && e >= 0;
}
function IS(e, t) {
  return `Invalid prop \`max\` of value \`${e}\` supplied to \`${t}\`. Only numbers greater than 0 are valid max values. Defaulting to \`${rl}\`.`;
}
function bS(e, t) {
  return `Invalid prop \`value\` of value \`${e}\` supplied to \`${t}\`. The \`value\` prop must be:
  - a positive number
  - less than the value passed to \`max\` (or ${rl} if no \`max\` prop is set)
  - \`null\` if the progress is indeterminate.

Defaulting to \`null\`.`;
}
const DS = oh,
  jS = zS,
  FS = me.li`
    display: flex; 
    flex-direction: column; 
    gap: 0.375rem;
`,
  BS = me.h2` 
    font-family: 'Poppins';
    font-style: normal;
    font-weight: 500;
    font-size: 0.75rem;
    line-height: 1.125rem;

    color: ${({ theme: e }) => e.COLORS.WHITE};
`,
  VS = me(DS)` 
    position: relative;
    overflow: hidden;

    background: ${(e) =>
      e.city ? "rgba(34, 232, 235, 0.4)" : "rgba(59, 130, 246, 0.4)"};
    border-radius: 0.0625rem;

    width: 100%;
    height: 0.125rem;

    transform: translateZ(0);
`,
  HS = me(jS)` 
    background-color: ${(e) =>
      e.city ? "rgba(34, 232, 235, 1)" : "rgba(59, 130, 246, 1)"};
    border-radius: 0.0625rem;

    width: 100%;
    height: 100%;

    transition: transform 660ms cubic-bezier(0.65, 0, 0.35, 1);
`;
function Ii({ label: e, value: t, city: n }) {
  const [r, i] = A.exports.useState(0);
  return (
    A.exports.useEffect(() => {
      const o = setTimeout(() => i(t), 200);
      return () => clearTimeout(o);
    }, []),
    Te(FS, {
      children: [
        G(BS, { children: e }),
        G(VS, {
          value: t,
          city: n === "hensa",
          children: G(HS, {
            city: n === "hensa",
            style: { transform: `translateX(-${100 - r}%)` },
          }),
        }),
      ],
    })
  );
}
const US = me.ul` 
    width: 11.5rem;
    height: 100%; 

    border-radius: 0.75rem;

    padding: 1.375rem;

    display: flex; 
    flex-direction: column;
    gap: 1.15rem;

    list-style-type: none;
`;
function WS({ body: e, engine: t, gas: n, chassi: r, city: i }) {
  return Te(US, {
    children: [
      // G(Ii, { city: i, label: "Chassis.", value: r / 10 }),
      G(Ii, { city: i, label: "Motor", value: t / 10 }),
      G(Ii, { city: i, label: "Lataria", value: e / 10 }),
      G(Ii, { city: i, label: "Gasolina", value: n }),
    ],
  });
}
function GS(e) {
  const t = xS.baseImagesURL,
    n = { model: e.model },
    r = () => {
      mn("taxVehicle", n).catch(() => {
      
      });
    },
    i = () => {
      mn("sellVehicle", n).catch(() => {
      
      });
    },
    o = () => {
      mn("transferVehicle", n).catch(() => {
      
      });
    };
  return Te(cS, {
    active: e.active,
    onClick: e.onClick,
    children: [
      G(SS, {
        imageURL: `${t.replace(/\/$/, "")}/${e.model}.png`,
        name: e.name,
        chest: e.chest,
        tax: e.tax,
        city: e.city,
        onTaxBuy: r,
        onSell: i,
        onTransfer: o,
      }),
      G(WS, {
        body: e.body,
        chassi: e.chassi,
        engine: e.engine,
        gas: e.gas,
        city: e.city,
      }),
    ],
  });
}
function YS({ vehicles: e, city: t }) {
  const { vehicle: n, setVehicle: r } = Dp(),
    { CATEGORIES: i, category: o, search: l } = ou(),
    a = (s) => {
      r(s);
    };
  return (
    A.exports.useEffect(() => {
      if (!!n) {
        if (o.type && o.type !== n.type) {
          r(null);
          return;
        }
        if (l) {
          const s = n.name.toLocaleLowerCase(),
            u = l.toLocaleLowerCase();
          if (!new RegExp(`^${u}`, "gmi").test(s)) {
            r(null);
            return;
          }
        }
      }
    }, [o, l]),
    A.exports.useEffect(() => {
      const s = document.querySelector(".swiper-slide");
      s && s.classList.add("scrollVehicle");
    }, [e]),
    G(rS, {
      direction: "vertical",
      slidesPerView: "auto",
      freeMode: !0,
      scrollbar: !0,
      mousewheel: !0,
      modules: [Gy, Wy, Hy],
      className: "scrollVehicle",
      children: G(iS, {
        children: e.map((s, u) => {
          let c = !0;
          if (l) {
            const f = s.name.toLocaleLowerCase(),
              d = l.toLocaleLowerCase();
            new RegExp(`^${d}`, "gmi").test(f) || (c = !1);
          }
          if (o.type)
            switch (o.type) {
              case "others":
                i.filter(({ type: f }) => f !== "others").forEach(
                  ({ type: f }) => {
                    f === s.type && (c = !1);
                  }
                );
                break;
              default:
                s.type !== o.type && (c = !1);
            }
          if (c)
            return G(
              GS,
              {
                active: (n == null ? void 0 : n.model) === s.model,
                onClick: () => a(s),
                city: t,
                ...s,
              },
              s.model + u
            );
        }),
      }),
    })
  );
}
const XS = me.section` 
    width: 32.5rem;
    height: 55.3125rem;

    display: flex; 
    flex-direction: column; 
    gap: 0.125rem; 

    border-radius: 0.75rem;
    overflow: hidden; 

    position: absolute; 
    top: 50%; 
    left: 8.75rem; 
    transform: translateY(-50%);
`;
setTimeout(() => {}, 1e3);
function QS() {
  const { visible: e } = T0(),
    [t, n] = A.exports.useState([]),
    [r, i] = A.exports.useState("tadalas");
  return (
    iu("OpenGarage", (o) => {
      n(o);
    }),
    mn("getCityName").then((o) => {
      i(o === "hensa" ? "hensa" : "");
    }),
    G(N0, {
      city: r,
      visible: e,
      children: G(XS, {
        children: G(A0, {
          children: Te($0, {
            children: [
              G(F0, { city: r, placeHolder: "Pesquisar um veículo" }),
              G(b0, {}),
              G(YS, { city: r, vehicles: t }),
              G(L0, { city: r }),
            ],
          }),
        }),
      }),
    })
  );
}
var KS = [{ path: ["/"], component: QS }];
function ZS() {
  const e = $g();
  return (
    iu("router", (t) => {
      e.push(t.path.replaceAll("/", "/"));
    }),
    G(li, {
      children: KS.map((t) =>
        G(
          Cg,
          { path: t.path, component: t.component, render: t.render, exact: !0 },
          "route-" + t.path[0]
        )
      ),
    })
  );
}
const qS = document.getElementById("root");
Yc.exports.render(
  G(E0, {
    children: Te(d0, {
      theme: P0,
      children: [
        G(_g, { children: G(kg, { children: G(ZS, {}) }) }),
        G(k0, {}),
      ],
    }),
  }),
  qS
);
