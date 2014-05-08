(function(a) {
	a.fn.uniqueName = function(c) {
		var b = a.extend({
			url : "/controller/action/",
			duplicateClass : "duplicate",
			duplicateMsg : "This name is taken; choose another.",
			uniqueClass : "unique",
			uniqueMsg : "This name is available.",
			loadingClass : "loading",
			data : {},
			template : "<span>&nbsp;</span>"
		}, c);
		return this.each(function() {
			var e = jQuery(this);
			var d = jQuery(b.template).insertAfter(e);
			var f = function() {
				if (a.trim(e.val()) != "") {
					b.data.name = e.val();
					d.addClass(b.loadingClass);
					jQuery.getJSON(b.url, b.data, function(g) {
						d.removeClass(b.loadingClass);
						if (g.is_unique) {
							d.addClass(b.uniqueClass);
							d.html(b.uniqueMsg);
							a(".ift-download-add").attr("disabled", false)
						} else {
							d.addClass(b.duplicateClass);
							d.html(g.message || b.duplicateMsg);
							a(".ift-download-add").attr("disabled", true)
						}
					})
				}
			};
			e.blur(f);
			e.focus(function() {
				d.html("&nbsp;").removeClass(b.duplicateClass).removeClass(
						b.uniqueClass)
			})
		})
	}
})(jQuery);
(function(a) {
	a.fn.messanger = function(c) {
		var b = a.extend({
			className : "message"
		}, c);
		return this.each(function() {
			var d = jQuery(this);
			var e = jQuery("<span></span>").insertAfter(d);
			d.bind("showMessage", function(g, f) {
				e.addClass(b.className);
				e.html(f)
			});
			d.bind("clearMessage", function() {
				e.html("").removeClass(b.className)
			})
		})
	}
})(jQuery);
(function(a) {
	a.fn.toggleEdit = function(c, b) {
		b = a.extend({}, {}, b);
		return this.each(function() {
			me = this;
			$inputArea = a(this).children(":first");
			$displayArea = a(this).children(":eq(1)");
			a(this).bind("open.toggleEdit", function(d) {
				$inputArea.show();
				$displayArea.hide()
			}).bind("close.toggleEdit", function(d) {
				$inputArea.hide();
				$displayArea.show().find("a").one("click", function(f) {
					a(me).trigger("open.toggleEdit");
					f.preventDefault()
				})
			}).bind("setContent.toggleEdit", function(f, d) {
				$displayArea.html(d);
				a(me).trigger("close.toggleEdit")
			});
			if (jQuery.trim($displayArea.html()) == "") {
				a(this).trigger("open.toggleEdit")
			} else {
				a(this).trigger("close.toggleEdit")
			}
		})
	}
})(jQuery);
(function(a) {
	a.fn.inlineFormTable = function(d, c) {
		c = a.extend({
			fetchingEditFormMsg : "Working..."
		}, {}, c);
		var e = 0;
		var b = 0;
		return this
				.each(function() {
					var g = a(this);
					var h = g.find("thead th").size();
					var f = '<tr class="ift-form-row"><td colspan="' + h + '">'
							+ c.fetchingEditFormMsg + "</td></tr>";
					g
							.click(
									function(o) {
										var n = a(o.target);
										if (n.is(".ift-edit")) {
											o.preventDefault();
											g.removeClass("ift-new-mode");
											g.trigger("removeFormRows");
											var p = a(n.parents("tr:first"));
											p.after(f);
											p.find("~ tr:first td").load(
													n.attr("href"))
										} else {
											if (n.is(".ift-download-add")) {
												if ((a("#uploaded_data").val()) == ""
														&& (a("#link_url")
																.val() == "")) {
													alert("Please select a file or enter the url for the location.");
													return
												}
												if (a("#title").val().length <= 1
														|| a("#title").val().length > 100) {
													alert("Title has be between 2 to 100 characters long");
													return
												}
												if (a("#description").val().length <= 1
														|| a("#description")
																.val().length > 200) {
													alert("Description has be between 2 to 200 characters long"
															+ a("#description"));
													return
												}
												var k = ('<div>  <table id="dtable" width="100%" style="table-layout:fixed"<thead > <tr> <th width="20%">File / URL<th width="20%" >Title</th><th width="30%">Description</th><th width="15%">Tags</th><th width="15%">Status</th></thead><tbody> </tbody></table>  </div>');
												var q = "";
												var m = "";
												var r = "";
												var u = "";
												var t = a(".Temp_file_table");
												if (e == 0) {
													t.prepend(k);
													a("#upload").attr("value",
															"Upload More")
												}
												q = a("#title")[0];
												m = a("#uploaded_data")[0].value
														|| a("#link_url")[0].value;
												r = a("#description")[0];
												u = a("#tag_list")[0];
												t = a("#dtable");
												row = "<tr id= row_"
														+ e
														+ '><td width="20%" height="20px" style="overflow:hidden">'
														+ m
														+ '</td><td width="20%" height="20px" style="overflow:hidden">'
														+ q.value
														+ '</td><td width="30%" height="20px" style="overflow:hidden">'
														+ r.value
														+ '</td><td width="15%" height="20px" style="overflow:hidden">'
														+ u.value
														+ "</td><td id= status_"
														+ e
														+ ' width="15%" height="20px" style="overflow:hidden">Uploading...</td></tr>';
												a("#dtable").append(row);
												a("#status_" + e).attr(
														"disabled", true);
												b++;
												var j;
												j = a("#download-column");
												a("#num_upload").attr("value",
														e);
												o.preventDefault();
												$form = n.parents("form");
												n
														.parents("form")
														.ajaxSubmit(
																{
																	dataType : "json",
																	resetForm : true,
																	success : function(
																			w) {
																		if (w.errors) {
																			var v = "<a href='#' id='err' class='contextMenuAnchor'><b><font color='red'>Error!</font></b></a><div id='err_content' style='display:none'>"
																					+ w.rawmessage
																					+ "</div>";
																			n
																					.parents(
																							"form")
																					.find(
																							".ift-errors")
																					.html(
																							w.html);
																			a(
																					"#status_"
																							+ w.download_count)
																					.attr(
																							"innerHTML",
																							v)
																		} else {
																			a(
																					"#status_"
																							+ w.download_count)
																					.attr(
																							"innerHTML",
																							"<font color='green'>Success</font>")
																		}
																	},
																	error : function(
																			v) {
																		errors = "<div id='errorExplanation' class='errorExplanation'><h2>Server is not responding</h2><ul><li></div>";
																		n
																				.parents(
																						"form")
																				.find(
																						".ift-errors")
																				.after(
																						errors)
																	}
																});
												e = e + 1;
												a(".ift-download-add").attr(
														"disabled", true);
												a(".unique_below").attr(
														"innerHTML", "");
												a(".unique_below").removeClass(
														"unique_below")
											} else {
												if (n
														.is(".ift-download-remove")) {
													row_num = n[0].id;
													a("#row_" + n[0].id)
															.remove();
													e = e - 1;
													if (e == 0) {
														a("#dtable").remove()
													}
													a(
															"#download-column_"
																	+ row_num)
															.remove();
													b--;
													if (b == 0) {
													}
												} else {
													if (n.is(".ift-new")) {
														o.preventDefault();
														g
																.trigger("removeFormRows");
														g
																.trigger(
																		"showNewForm",
																		[ n
																				.attr("href") ])
													} else {
														if (n.is(".ift-done")) {
															if (e > 0) {
																for (i = 0; i < e; i++) {
																	if (a(
																			"#status_"
																					+ i)
																			.attr(
																					"innerHTML") == "Uploading...") {
																		i = e;
																		var l = confirm("You have pending Uploads.  Are you sure you want to cancel?");
																		if (l) {
																			o
																					.preventDefault();
																			g
																					.trigger("removeFormRows");
																			g
																					.removeClass("ift-new-mode");
																			e = 0;
																			return true
																		} else {
																			return false
																		}
																	}
																}
																document.location.href = "";
																o
																		.preventDefault();
																g
																		.trigger("removeFormRows");
																g
																		.removeClass("ift-new-mode");
																e = 0
															} else {
																document.location.href = "";
																o
																		.preventDefault();
																g
																		.trigger("removeFormRows");
																g
																		.removeClass("ift-new-mode");
																e = 0
															}
														} else {
															if (n
																	.is(".ift-cancel")) {
																o
																		.preventDefault();
																g
																		.trigger("removeFormRows");
																g
																		.removeClass("ift-new-mode")
															} else {
																if (n
																		.is(".ift-submit")) {
																	o
																			.preventDefault();
																	$form = n
																			.parents("form");
																	$form
																			.find(
																					"#ift-button-panel")
																			.hide();
																	$form
																			.find(
																					"#ift-submit-notice")
																			.show();
																	$form
																			.find(
																					"#buttons")
																			.hide();
																	if (a("#errorExplanation").length) {
																		$form
																				.find(
																						"#errorExplanation")
																				.css(
																						"display",
																						"none")
																	}
																	$form
																			.find(
																					"#loading")
																			.show();
																	n
																			.parents(
																					"form")
																			.ajaxSubmit(
																					{
																						dataType : "json",
																						success : function(
																								v) {
																							$form
																									.find(
																											"#ift-submit-notice")
																									.hide();
																							$form
																									.find(
																											"#ift-button-panel")
																									.show();
																							if (v.errors) {
																								n
																										.parents(
																												"form")
																										.find(
																												".ift-errors")
																										.html(
																												v.html);
																								$form
																										.find(
																												"#buttons")
																										.show();
																								$form
																										.find(
																												"#loading")
																										.hide()
																							} else {
																								g
																										.removeClass(
																												"ift-new-mode")
																										.find(
																												"table")
																										.replaceWith(
																												v.html);
																								g
																										.find(
																												"table")
																										.css(
																												"background",
																												"#ffff00")
																										.animate(
																												{
																													backgroundColor : "#ffffff"
																												},
																												1500)
																							}
																						},
																						error : function(
																								v) {
																							errors = "<div id='errorExplanation' class='errorExplanation'><h2>Server is not responding</h2><ul><li></div>";
																							$form
																									.find(
																											"#ift-submit-notice")
																									.hide();
																							$form
																									.find(
																											"#ift-button-panel")
																									.show();
																							n
																									.parents(
																											"form")
																									.find(
																											".ift-errors")
																									.after(
																											errors);
																							$form
																									.find(
																											"#buttons")
																									.show();
																							$form
																									.find(
																											"#loading")
																									.hide()
																						}
																					})
																}
															}
														}
													}
												}
											}
										}
									}).bind("removeFormRows", function(k, j) {
								g.find(".ift-form-row").remove()
							}).bind("showNewForm", function(k, j) {
								g.addClass("ift-new-mode");
								$tb = g.find("tbody");
								$tb.prepend(f);
								$tb.find("tr.ift-form-row td").load(j)
							})
				})
	}
})(jQuery);
$.fn.hoverClass = function(a) {
	return this.each(function() {
		$(this).hover(function() {
			$(this).addClass(a)
		}, function() {
			$(this).removeClass(a)
		})
	})
};
(function(d) {
	d
			.each(
					[ "backgroundColor", "borderBottomColor",
							"borderLeftColor", "borderRightColor",
							"borderTopColor", "color", "outlineColor" ],
					function(f, e) {
						d.fx.step[e] = function(g) {
							if (g.state == 0) {
								g.start = c(g.elem, e);
								g.end = b(g.end)
							}
							g.elem.style[e] = "rgb("
									+ [
											Math
													.max(
															Math
																	.min(
																			parseInt((g.pos * (g.end[0] - g.start[0]))
																					+ g.start[0]),
																			255),
															0),
											Math
													.max(
															Math
																	.min(
																			parseInt((g.pos * (g.end[1] - g.start[1]))
																					+ g.start[1]),
																			255),
															0),
											Math
													.max(
															Math
																	.min(
																			parseInt((g.pos * (g.end[2] - g.start[2]))
																					+ g.start[2]),
																			255),
															0) ].join(",")
									+ ")"
						}
					});
	function b(f) {
		var e;
		if (f && f.constructor == Array && f.length == 3) {
			return f
		}
		if (e = /rgb\(\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*\)/
				.exec(f)) {
			return [ parseInt(e[1]), parseInt(e[2]), parseInt(e[3]) ]
		}
		if (e = /rgb\(\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*\)/
				.exec(f)) {
			return [ parseFloat(e[1]) * 2.55, parseFloat(e[2]) * 2.55,
					parseFloat(e[3]) * 2.55 ]
		}
		if (e = /#([a-fA-F0-9]{2})([a-fA-F0-9]{2})([a-fA-F0-9]{2})/.exec(f)) {
			return [ parseInt(e[1], 16), parseInt(e[2], 16), parseInt(e[3], 16) ]
		}
		if (e = /#([a-fA-F0-9])([a-fA-F0-9])([a-fA-F0-9])/.exec(f)) {
			return [ parseInt(e[1] + e[1], 16), parseInt(e[2] + e[2], 16),
					parseInt(e[3] + e[3], 16) ]
		}
		return a[d.trim(f).toLowerCase()]
	}
	function c(g, e) {
		var f;
		do {
			f = d.curCSS(g, e);
			if (f != "" && f != "transparent" || d.nodeName(g, "body")) {
				break
			}
			e = "backgroundColor"
		} while (g = g.parentNode);
		return b(f)
	}
	var a = {
		aqua : [ 0, 255, 255 ],
		azure : [ 240, 255, 255 ],
		beige : [ 245, 245, 220 ],
		black : [ 0, 0, 0 ],
		blue : [ 0, 0, 255 ],
		brown : [ 165, 42, 42 ],
		cyan : [ 0, 255, 255 ],
		darkblue : [ 0, 0, 139 ],
		darkcyan : [ 0, 139, 139 ],
		darkgrey : [ 169, 169, 169 ],
		darkgreen : [ 0, 100, 0 ],
		darkkhaki : [ 189, 183, 107 ],
		darkmagenta : [ 139, 0, 139 ],
		darkolivegreen : [ 85, 107, 47 ],
		darkorange : [ 255, 140, 0 ],
		darkorchid : [ 153, 50, 204 ],
		darkred : [ 139, 0, 0 ],
		darksalmon : [ 233, 150, 122 ],
		darkviolet : [ 148, 0, 211 ],
		fuchsia : [ 255, 0, 255 ],
		gold : [ 255, 215, 0 ],
		green : [ 0, 128, 0 ],
		indigo : [ 75, 0, 130 ],
		khaki : [ 240, 230, 140 ],
		lightblue : [ 173, 216, 230 ],
		lightcyan : [ 224, 255, 255 ],
		lightgreen : [ 144, 238, 144 ],
		lightgrey : [ 211, 211, 211 ],
		lightpink : [ 255, 182, 193 ],
		lightyellow : [ 255, 255, 224 ],
		lime : [ 0, 255, 0 ],
		magenta : [ 255, 0, 255 ],
		maroon : [ 128, 0, 0 ],
		navy : [ 0, 0, 128 ],
		olive : [ 128, 128, 0 ],
		orange : [ 255, 165, 0 ],
		pink : [ 255, 192, 203 ],
		purple : [ 128, 0, 128 ],
		violet : [ 128, 0, 128 ],
		red : [ 255, 0, 0 ],
		silver : [ 192, 192, 192 ],
		white : [ 255, 255, 255 ],
		yellow : [ 255, 255, 0 ]
	}
})(jQuery);
(function($) {
	$.extend({
		metadata : {
			defaults : {
				type : "class",
				name : "metadata",
				cre : /({.*})/,
				single : "metadata"
			},
			setType : function(type, name) {
				this.defaults.type = type;
				this.defaults.name = name
			},
			get : function(elem, opts) {
				var settings = $.extend({}, this.defaults, opts);
				if (!settings.single.length) {
					settings.single = "metadata"
				}
				var data = $.data(elem, settings.single);
				if (data) {
					return data
				}
				data = "{}";
				if (settings.type == "class") {
					var m = settings.cre.exec(elem.className);
					if (m) {
						data = m[1]
					}
				} else {
					if (settings.type == "elem") {
						if (!elem.getElementsByTagName) {
							return
						}
						var e = elem.getElementsByTagName(settings.name);
						if (e.length) {
							data = $.trim(e[0].innerHTML)
						}
					} else {
						if (elem.getAttribute != undefined) {
							var attr = elem.getAttribute(settings.name);
							if (attr) {
								data = attr
							}
						}
					}
				}
				if (data.indexOf("{") < 0) {
					data = "{" + data + "}"
				}
				data = eval("(" + data + ")");
				$.data(elem, settings.single, data);
				return data
			}
		}
	});
	$.fn.metadata = function(opts) {
		return $.metadata.get(this[0], opts)
	}
})(jQuery);
(function(a) {
	a.extend(a.fn, {
		livequery : function(f, e, d) {
			var c = this, g;
			if (a.isFunction(f)) {
				d = e, e = f, f = undefined
			}
			a.each(a.livequery.queries, function(h, j) {
				if (c.selector == j.selector && c.context == j.context
						&& f == j.type && (!e || e.$lqguid == j.fn.$lqguid)
						&& (!d || d.$lqguid == j.fn2.$lqguid)) {
					return (g = j) && false
				}
			});
			g = g || new a.livequery(this.selector, this.context, f, e, d);
			g.stopped = false;
			a.livequery.run(g.id);
			return this
		},
		expire : function(f, e, d) {
			var c = this;
			if (a.isFunction(f)) {
				d = e, e = f, f = undefined
			}
			a.each(a.livequery.queries,
					function(g, h) {
						if (c.selector == h.selector && c.context == h.context
								&& (!f || f == h.type)
								&& (!e || e.$lqguid == h.fn.$lqguid)
								&& (!d || d.$lqguid == h.fn2.$lqguid)
								&& !this.stopped) {
							a.livequery.stop(h.id)
						}
					});
			return this
		}
	});
	a.livequery = function(c, e, g, f, d) {
		this.selector = c;
		this.context = e || document;
		this.type = g;
		this.fn = f;
		this.fn2 = d;
		this.elements = [];
		this.stopped = false;
		this.id = a.livequery.queries.push(this) - 1;
		f.$lqguid = f.$lqguid || a.livequery.guid++;
		if (d) {
			d.$lqguid = d.$lqguid || a.livequery.guid++
		}
		return this
	};
	a.livequery.prototype = {
		stop : function() {
			var c = this;
			if (this.type) {
				this.elements.unbind(this.type, this.fn)
			} else {
				if (this.fn2) {
					this.elements.each(function(d, e) {
						c.fn2.apply(e)
					})
				}
			}
			this.elements = [];
			this.stopped = true
		},
		run : function() {
			if (this.stopped) {
				return
			}
			var e = this;
			var f = this.elements, d = a(this.selector, this.context), c = d
					.not(f);
			this.elements = d;
			if (this.type) {
				c.bind(this.type, this.fn);
				if (f.length > 0) {
					a.each(f, function(g, h) {
						if (a.inArray(h, d) < 0) {
							a.event.remove(h, e.type, e.fn)
						}
					})
				}
			} else {
				c.each(function() {
					e.fn.apply(this)
				});
				if (this.fn2 && f.length > 0) {
					a.each(f, function(g, h) {
						if (a.inArray(h, d) < 0) {
							e.fn2.apply(h)
						}
					})
				}
			}
		}
	};
	a.extend(a.livequery, {
		guid : 0,
		queries : [],
		queue : [],
		running : false,
		timeout : null,
		checkQueue : function() {
			if (a.livequery.running && a.livequery.queue.length) {
				var c = a.livequery.queue.length;
				while (c--) {
					a.livequery.queries[a.livequery.queue.shift()].run()
				}
			}
		},
		pause : function() {
			a.livequery.running = false
		},
		play : function() {
			a.livequery.running = true;
			a.livequery.run()
		},
		registerPlugin : function() {
			a.each(arguments, function(d, e) {
				if (!a.fn[e]) {
					return
				}
				var c = a.fn[e];
				a.fn[e] = function() {
					var f = c.apply(this, arguments);
					a.livequery.run();
					return f
				}
			})
		},
		run : function(c) {
			if (c != undefined) {
				if (a.inArray(c, a.livequery.queue) < 0) {
					a.livequery.queue.push(c)
				}
			} else {
				a.each(a.livequery.queries, function(d) {
					if (a.inArray(d, a.livequery.queue) < 0) {
						a.livequery.queue.push(d)
					}
				})
			}
			if (a.livequery.timeout) {
				clearTimeout(a.livequery.timeout)
			}
			a.livequery.timeout = setTimeout(a.livequery.checkQueue, 20)
		},
		stop : function(c) {
			if (c != undefined) {
				a.livequery.queries[c].stop()
			} else {
				a.each(a.livequery.queries, function(d) {
					a.livequery.queries[d].stop()
				})
			}
		}
	});
	a.livequery.registerPlugin("append", "prepend", "after", "before", "wrap",
			"attr", "removeAttr", "addClass", "removeClass", "toggleClass",
			"empty", "remove");
	a(function() {
		a.livequery.play()
	});
	var b = a.prototype.init;
	a.prototype.init = function(d, f) {
		var e = b.apply(this, arguments);
		if (d && d.selector) {
			e.context = d.context, e.selector = d.selector
		}
		if (typeof d == "string") {
			e.context = f || document, e.selector = d
		}
		return e
	};
	a.prototype.init.prototype = a.prototype
})(jQuery);
(function(d) {
	d.fn.jqm = function(f) {
		var e = {
			overlay : 50,
			overlayClass : "jqmOverlay",
			closeClass : "jqmClose",
			trigger : ".jqModal",
			ajax : o,
			ajaxText : "",
			target : o,
			modal : o,
			toTop : o,
			onShow : o,
			onHide : o,
			onLoad : o
		};
		return this.each(function() {
			if (this._jqm) {
				return n[this._jqm].c = d.extend({}, n[this._jqm].c, f)
			}
			p++;
			this._jqm = p;
			n[p] = {
				c : d.extend(e, d.jqm.params, f),
				a : o,
				w : d(this).addClass("jqmID" + p),
				s : p
			};
			if (e.trigger) {
				d(this).jqmAddTrigger(e.trigger)
			}
		})
	};
	d.fn.jqmAddClose = function(f) {
		return l(this, f, "jqmHide")
	};
	d.fn.jqmAddTrigger = function(f) {
		return l(this, f, "jqmShow")
	};
	d.fn.jqmShow = function(e) {
		return this.each(function() {
			e = e || window.event;
			d.jqm.open(this._jqm, e)
		})
	};
	d.fn.jqmHide = function(e) {
		return this.each(function() {
			e = e || window.event;
			d.jqm.close(this._jqm, e)
		})
	};
	d.jqm = {
		hash : {},
		open : function(C, B) {
			var q = n[C], v = q.c, m = "." + v.closeClass, w = (parseInt(q.w
					.css("z-index"))), w = (w > 0) ? w : 3000, f = d(
					"<div></div>").css({
				height : "100%",
				width : "100%",
				position : "fixed",
				left : 0,
				top : 0,
				"z-index" : w - 1,
				opacity : v.overlay / 100
			});
			if (q.a) {
				return o
			}
			q.t = B;
			q.a = true;
			q.w.css("z-index", w);
			if (v.modal) {
				if (!a[0]) {
					k("bind")
				}
				a.push(C)
			} else {
				if (v.overlay > 0) {
					q.w.jqmAddClose(f)
				} else {
					f = o
				}
			}
			q.o = (f) ? f.addClass(v.overlayClass).prependTo("body") : o;
			if (c) {
				d("html,body").css({
					height : "100%",
					width : "100%"
				});
				if (f) {
					f = f.css({
						position : "absolute"
					})[0];
					for ( var x in {
						Top : 1,
						Left : 1
					}) {
						f.style.setExpression(x.toLowerCase(),
								"(_=(document.documentElement.scroll" + x
										+ " || document.body.scroll " + x
										+ "))+'px'")
					}
				}
			}
			if (v.ajax) {
				var e = v.target || q.w, A = v.ajax, e = (typeof e == "string") ? d(
						e, q.w)
						: d(e), A = (A.substr(0, 1) == "@") ? d(B).attr(
						A.substring(1)) : A;
				e.html(v.ajaxText).load(A, function() {
					if (v.onLoad) {
						v.onLoad.call(this, q)
					}
					if (m) {
						q.w.jqmAddClose(d(m, q.w))
					}
					j(q)
				})
			} else {
				if (m) {
					q.w.jqmAddClose(d(m, q.w))
				}
			}
			if (v.toTop && q.o) {
				q.w.before('<span id="jqmP' + q.w[0]._jqm + '"></span>')
						.insertAfter(q.o)
			}
			(v.onShow) ? v.onShow(q) : q.w.show();
			j(q);
			return o
		},
		close : function(f) {
			var e = n[f];
			if (!e.a) {
				return o
			}
			e.a = o;
			if (a[0]) {
				a.pop();
				if (!a[0]) {
					k("unbind")
				}
			}
			if (e.c.toTop && e.o) {
				d("#jqmP" + e.w[0]._jqm).after(e.w).remove()
			}
			if (e.c.onHide) {
				e.c.onHide(e)
			} else {
				e.w.hide();
				if (e.o) {
					e.o.remove()
				}
			}
			return o
		},
		params : {}
	};
	var p = 0, n = d.jqm.hash, a = [], c = d.browser.msie
			&& (d.browser.version == "6.0"), o = false, g = d(
			'<iframe src="javascript:false;document.write(\'\');" class="jqm"></iframe>')
			.css({
				opacity : 0
			}), j = function(e) {
		if (c) {
			if (e.o) {
				e.o.html('<p style="width:100%;height:100%"/>').prepend(g)
			} else {
				if (!d("iframe.jqm", e.w)[0]) {
					e.w.prepend(g)
				}
			}
		}
		h(e)
	}, h = function(f) {
		try {
			d(":input:visible", f.w)[0].focus()
		} catch (e) {
		}
	}, k = function(e) {
		d()[e]("keypress", b)[e]("keydown", b)[e]("mousedown", b)
	}, b = function(q) {
		var f = n[a[a.length - 1]], m = (!d(q.target).parents(".jqmID" + f.s)[0]);
		if (m) {
			h(f)
		}
		return !m
	}, l = function(e, f, m) {
		return e.each(function() {
			var q = this._jqm;
			d(f).each(function() {
				if (!this[m]) {
					this[m] = [];
					d(this).click(function() {
						for ( var r in {
							jqmShow : 1,
							jqmHide : 1
						}) {
							for ( var t in this[r]) {
								if (n[this[r][t]]) {
									n[this[r][t]].w[r](this)
								}
							}
						}
						return o
					})
				}
				this[m].push(q)
			})
		})
	}
})(jQuery);
(function(a) {
	a.ui = a.ui || {};
	a.ui.autocomplete = a.ui.autocomplete || {};
	var b;
	a.fn.autocompleteMode = function(d, f, j, h) {
		var g = f.val();
		var k = -1;
		var e = this;
		a.data(document.body, "autocompleteMode", true);
		a("body").one("cancel.autocomplete", function() {
			f.trigger("cancel.autocomplete");
			a("body").trigger("off.autocomplete");
			f.val(g)
		});
		a("body").one(
				"activate.autocomplete",
				function() {
					if (b) {
						f.trigger("activate.autocomplete", [ a.data(b[0],
								"originalObject") ])
					}
					a("body").trigger("off.autocomplete")
				});
		a("body").one(
				"off.autocomplete",
				function(m, l) {
					d.remove();
					a.data(document.body, "autocompleteMode", false);
					f.unbind("keydown.autocomplete");
					a("body").add(window).unbind("click.autocomplete").unbind(
							"cancel.autocomplete").unbind(
							"activate.autocomplete")
				});
		a(window).bind("click.autocomplete", function() {
			a("body").trigger("cancel.autocomplete")
		});
		var c = function() {
			b = a("li", d).removeClass("active").slice(k, k + 1).addClass(
					"active");
			f.trigger("itemSelected.autocomplete", [ a.data(b[0],
					"originalObject") ]);
			f.val(h.insertText(a.data(b[0], "originalObject")))
		};
		d.mouseover(
				function(l) {
					if (l.target == d[0]) {
						return
					}
					k = a("li", d).index(
							a(l.target).is("li") ? a(l.target)[0] : a(l.target)
									.parents("li")[0]);
					c()
				}).bind("click.autocomplete", function(l) {
			a("body").trigger("activate.autocomplete");
			a.data(document.body, "suppressKey", false)
		});
		f.bind("keydown.autocomplete", function(l) {
			if (l.which == 27) {
				a("body").trigger("cancel.autocomplete")
			} else {
				if (l.which == 13) {
					a("body").trigger("activate.autocomplete")
				} else {
					if (l.which == 40 || l.which == 9 || l.which == 38) {
						switch (l.which) {
						case 40:
						case 9:
							k = k >= j - 1 ? 0 : k + 1;
							break;
						case 38:
							k = k <= 0 ? j - 1 : k - 1;
							break;
						default:
							break
						}
						c()
					} else {
						return true
					}
				}
			}
			a.data(document.body, "suppressKey", true)
		})
	};
	a.fn.autocomplete = function(c) {
		c = a.extend({}, {
			timeout : 1000,
			getList : function(e) {
				e.trigger("updateList", [ c.list ])
			},
			template : function(e) {
				return "<li>" + c.insertText(e) + "</li>"
			},
			insertText : function(e) {
				return e
			},
			match : function(e) {
				return this.match(new RegExp(e))
			},
			wrapper : "<ul class='jq-ui-autocomplete'></ul>",
			anchor : "body"
		}, c);
		if (a.ui.autocomplete.ext) {
			for ( var d in a.ui.autocomplete.ext) {
				if (c[d]) {
					c = a.extend(c, a.ui.autocomplete.ext[d](c));
					delete c[d]
				}
			}
		}
		return this.each(function() {
			a(this).keypress(
					function(g) {
						var f = a.data(this, "typingTimeout");
						if (f) {
							window.clearInterval(f)
						}
						if (a.data(document.body, "suppressKey")) {
							return a.data(document.body, "suppressKey", false)
						} else {
							if (a.data(document.body, "autocompleteMode")
									&& g.charCode < 32 && g.keyCode != 8
									&& g.keyCode != 46) {
								return false
							} else {
								a.data(this, "typingTimeout", window
										.setTimeout(function() {
											a(g.target).trigger("autocomplete")
										}, c.timeout))
							}
						}
					}).bind("autocomplete", function() {
				var e = a(this);
				e.one("updateList", function(h, g) {
					g = a(g).filter(function() {
						return c.match.call(this, e.val())
					}).map(function() {
						var k = a(c.template(this))[0];
						a.data(k, "originalObject", this);
						return k
					});
					a("body").trigger("off.autocomplete");
					if (!g.length) {
						return false
					}
					var f = g.wrapAll(c.wrapper).parents(":last").children();
					var j = e.offset();
					c.container = f.css({
						top : j.top + e.outerHeight(),
						left : j.left,
						width : e.width()
					}).appendTo(c.anchor);
					a("body").autocompleteMode(f, e, g.length, c)
				});
				c.getList(e)
			})
		})
	}
})(jQuery);
(function(a) {
	a.ui = a.ui || {};
	a.ui.autocomplete = a.ui.autocomplete || {};
	a.ui.autocomplete.ext = a.ui.autocomplete.ext || {};
	a.ui.autocomplete.ext.ajax = function(b) {
		var c = b.ajax;
		return {
			getList : function(d) {
				a.getJSON(c, "val=" + d.val(), function(e) {
					d.trigger("updateList", [ e ])
				})
			}
		}
	};
	a.ui.autocomplete.ext.templateText = function(b) {
		var c = a.makeTemplate(b.templateText, "<%", "%>");
		return {
			template : function(d) {
				return c(d)
			}
		}
	}
})(jQuery);
(function(a) {
	a.fn.ajaxSubmit = function(m) {
		if (typeof m == "function") {
			m = {
				success : m
			}
		}
		m = a.extend({
			url : this.attr("action") || window.location.toString(),
			type : this.attr("method") || "GET"
		}, m || {});
		var p = {};
		this.trigger("form-pre-serialize", [ this, m, p ]);
		if (p.veto) {
			return this
		}
		var g = this.formToArray(m.semantic);
		if (m.data) {
			m.extraData = m.data;
			for ( var d in m.data) {
				g.push({
					name : d,
					value : m.data[d]
				})
			}
		}
		if (m.beforeSubmit && m.beforeSubmit(g, this, m) === false) {
			return this
		}
		this.trigger("form-submit-validate", [ g, this, m, p ]);
		if (p.veto) {
			return this
		}
		var c = a.param(g);
		if (m.type.toUpperCase() == "GET") {
			m.url += (m.url.indexOf("?") >= 0 ? "&" : "?") + c;
			m.data = null
		} else {
			m.data = c
		}
		var o = this, f = [];
		if (m.resetForm) {
			f.push(function() {
				o.resetForm()
			})
		}
		if (m.clearForm) {
			f.push(function() {
				o.clearForm()
			})
		}
		if (!m.dataType && m.target) {
			var k = m.success || function() {
			};
			f.push(function(j) {
				a(m.target).html(j).each(k, arguments)
			})
		} else {
			if (m.success) {
				f.push(m.success)
			}
		}
		m.success = function(r, n) {
			for ( var q = 0, j = f.length; q < j; q++) {
				f[q](r, n, o)
			}
		};
		var b = a("input:file", this).fieldValue();
		var l = false;
		for ( var e = 0; e < b.length; e++) {
			if (b[e]) {
				l = true
			}
		}
		if (m.iframe || l) {
			if (a.browser.safari && m.closeKeepAlive) {
				a.get(m.closeKeepAlive, h)
			} else {
				h()
			}
		} else {
			a.ajax(m)
		}
		this.trigger("form-submit-notify", [ this, m ]);
		return this;
		function h() {
			var r = o[0];
			var n = a.extend({}, a.ajaxSettings, m);
			var q = "jqFormIO" + (new Date().getTime());
			var w = a('<iframe id="' + q + '" name="' + q + '" />');
			var y = w[0];
			var z = a.browser.opera && window.opera.version() < 9;
			if (a.browser.msie || z) {
				y.src = 'javascript:false;document.write("");'
			}
			w.css({
				position : "absolute",
				top : "-1000px",
				left : "-1000px"
			});
			var A = {
				responseText : null,
				responseXML : null,
				status : 0,
				statusText : "n/a",
				getAllResponseHeaders : function() {
				},
				getResponseHeader : function() {
				},
				setRequestHeader : function() {
				}
			};
			var x = n.global;
			if (x && !a.active++) {
				a.event.trigger("ajaxStart")
			}
			if (x) {
				a.event.trigger("ajaxSend", [ A, n ])
			}
			var j = 0;
			var t = 0;
			setTimeout(function() {
				var D = o.attr("target"), B = o.attr("action");
				o.attr({
					target : q,
					encoding : "multipart/form-data",
					enctype : "multipart/form-data",
					method : "POST",
					action : n.url
				});
				if (n.timeout) {
					setTimeout(function() {
						t = true;
						u()
					}, n.timeout)
				}
				var C = [];
				try {
					if (m.extraData) {
						for ( var E in m.extraData) {
							C.push(a(
									'<input type="hidden" name="' + E
											+ '" value="' + m.extraData[E]
											+ '" />').appendTo(r)[0])
						}
					}
					w.appendTo("body");
					y.attachEvent ? y.attachEvent("onload", u) : y
							.addEventListener("load", u, false);
					r.submit()
				} finally {
					o.attr("action", B);
					D ? o.attr("target", D) : o.removeAttr("target");
					a(C).remove()
				}
			}, 10);
			function u() {
				if (j++) {
					return
				}
				y.detachEvent ? y.detachEvent("onload", u) : y
						.removeEventListener("load", u, false);
				var C = true;
				try {
					if (t) {
						throw "timeout"
					}
					var D, F;
					F = y.contentWindow ? y.contentWindow.document
							: y.contentDocument ? y.contentDocument
									: y.document;
					A.responseText = F.body ? F.body.innerHTML : null;
					A.responseXML = F.XMLDocument ? F.XMLDocument : F;
					A.getResponseHeader = function(H) {
						var G = {
							"content-type" : n.dataType
						};
						return G[H]
					};
					if (n.dataType == "json" || n.dataType == "script") {
						var B = F.getElementsByTagName("textarea")[0];
						A.responseText = B ? B.value : A.responseText
					} else {
						if (n.dataType == "xml" && !A.responseXML
								&& A.responseText != null) {
							A.responseXML = v(A.responseText)
						}
					}
					D = a.httpData(A, n.dataType)
				} catch (E) {
					C = false;
					a.handleError(n, A, "error", E)
				}
				if (C) {
					n.success(D, "success");
					if (x) {
						a.event.trigger("ajaxSuccess", [ A, n ])
					}
				}
				if (x) {
					a.event.trigger("ajaxComplete", [ A, n ])
				}
				if (x && !--a.active) {
					a.event.trigger("ajaxStop")
				}
				if (n.complete) {
					n.complete(A, C ? "success" : "error")
				}
				setTimeout(function() {
					w.remove();
					A.responseXML = null
				}, 100)
			}
			function v(B, C) {
				if (window.ActiveXObject) {
					C = new ActiveXObject("Microsoft.XMLDOM");
					C.async = "false";
					C.loadXML(B)
				} else {
					C = (new DOMParser()).parseFromString(B, "text/xml")
				}
				return (C && C.documentElement && C.documentElement.tagName != "parsererror") ? C
						: null
			}
		}
	};
	a.fn.ajaxForm = function(b) {
		return this
				.ajaxFormUnbind()
				.bind("submit.form-plugin", function() {
					a(this).ajaxSubmit(b);
					return false
				})
				.each(
						function() {
							a(":submit,input:image", this)
									.bind(
											"click.form-plugin",
											function(d) {
												var c = this.form;
												c.clk = this;
												if (this.type == "image") {
													if (d.offsetX != undefined) {
														c.clk_x = d.offsetX;
														c.clk_y = d.offsetY
													} else {
														if (typeof a.fn.offset == "function") {
															var f = a(this)
																	.offset();
															c.clk_x = d.pageX
																	- f.left;
															c.clk_y = d.pageY
																	- f.top
														} else {
															c.clk_x = d.pageX
																	- this.offsetLeft;
															c.clk_y = d.pageY
																	- this.offsetTop
														}
													}
												}
												setTimeout(
														function() {
															c.clk = c.clk_x = c.clk_y = null
														}, 10)
											})
						})
	};
	a.fn.ajaxFormUnbind = function() {
		this.unbind("submit.form-plugin");
		return this.each(function() {
			a(":submit,input:image", this).unbind("click.form-plugin")
		})
	};
	a.fn.formToArray = function(p) {
		var o = [];
		if (this.length == 0) {
			return o
		}
		var c = this[0];
		var g = p ? c.getElementsByTagName("*") : c.elements;
		if (!g) {
			return o
		}
		for ( var h = 0, l = g.length; h < l; h++) {
			var d = g[h];
			var e = d.name;
			if (!e) {
				continue
			}
			if (p && c.clk && d.type == "image") {
				if (!d.disabled && c.clk == d) {
					o.push({
						name : e + ".x",
						value : c.clk_x
					}, {
						name : e + ".y",
						value : c.clk_y
					})
				}
				continue
			}
			var q = a.fieldValue(d, true);
			if (q && q.constructor == Array) {
				for ( var f = 0, b = q.length; f < b; f++) {
					o.push({
						name : e,
						value : q[f]
					})
				}
			} else {
				if (q !== null && typeof q != "undefined") {
					o.push({
						name : e,
						value : q
					})
				}
			}
		}
		if (!p && c.clk) {
			var k = c.getElementsByTagName("input");
			for ( var h = 0, l = k.length; h < l; h++) {
				var m = k[h];
				var e = m.name;
				if (e && !m.disabled && m.type == "image" && c.clk == m) {
					o.push({
						name : e + ".x",
						value : c.clk_x
					}, {
						name : e + ".y",
						value : c.clk_y
					})
				}
			}
		}
		return o
	};
	a.fn.formSerialize = function(b) {
		return a.param(this.formToArray(b))
	};
	a.fn.fieldSerialize = function(c) {
		var b = [];
		this.each(function() {
			var g = this.name;
			if (!g) {
				return
			}
			var e = a.fieldValue(this, c);
			if (e && e.constructor == Array) {
				for ( var f = 0, d = e.length; f < d; f++) {
					b.push({
						name : g,
						value : e[f]
					})
				}
			} else {
				if (e !== null && typeof e != "undefined") {
					b.push({
						name : this.name,
						value : e
					})
				}
			}
		});
		return a.param(b)
	};
	a.fn.fieldValue = function(g) {
		for ( var f = [], d = 0, b = this.length; d < b; d++) {
			var e = this[d];
			var c = a.fieldValue(e, g);
			if (c === null || typeof c == "undefined"
					|| (c.constructor == Array && !c.length)) {
				continue
			}
			c.constructor == Array ? a.merge(f, c) : f.push(c)
		}
		return f
	};
	a.fieldValue = function(b, h) {
		var d = b.name, o = b.type, p = b.tagName.toLowerCase();
		if (typeof h == "undefined") {
			h = true
		}
		if (h
				&& (!d || b.disabled || o == "reset" || o == "button"
						|| (o == "checkbox" || o == "radio") && !b.checked
						|| (o == "submit" || o == "image") && b.form
						&& b.form.clk != b || p == "select"
						&& b.selectedIndex == -1)) {
			return null
		}
		if (p == "select") {
			var j = b.selectedIndex;
			if (j < 0) {
				return null
			}
			var l = [], c = b.options;
			var f = (o == "select-one");
			var k = (f ? j + 1 : c.length);
			for ( var e = (f ? j : 0); e < k; e++) {
				var g = c[e];
				if (g.selected) {
					var m = a.browser.msie && !(g.attributes.value.specified) ? g.text
							: g.value;
					if (f) {
						return m
					}
					l.push(m)
				}
			}
			return l
		}
		return b.value
	};
	a.fn.clearForm = function() {
		return this.each(function() {
			a("input,select,textarea", this).clearFields()
		})
	};
	a.fn.clearFields = a.fn.clearInputs = function() {
		return this.each(function() {
			var c = this.type, b = this.tagName.toLowerCase();
			if (c == "text" || c == "password" || b == "textarea") {
				this.value = ""
			} else {
				if (c == "checkbox" || c == "radio") {
					this.checked = false
				} else {
					if (b == "select") {
						this.selectedIndex = -1
					}
				}
			}
		})
	};
	a.fn.resetForm = function() {
		return this
				.each(function() {
					if (typeof this.reset == "function"
							|| (typeof this.reset == "object" && !this.reset.nodeType)) {
						this.reset()
					}
				})
	};
	a.fn.enable = function(c) {
		if (c == undefined) {
			c = true
		}
		return this.each(function() {
			this.disabled = !c
		})
	};
	a.fn.select = function(b) {
		if (b == undefined) {
			b = true
		}
		return this.each(function() {
			var c = this.type;
			if (c == "checkbox" || c == "radio") {
				this.checked = b
			} else {
				if (this.tagName.toLowerCase() == "option") {
					var d = a(this).parent("select");
					if (b && d[0] && d[0].type == "select-one") {
						d.find("option").select(false)
					}
					this.selected = b
				}
			}
		})
	}
})(jQuery);
jQuery.autocompleteP = function(d, v) {
	var p = this;
	var z = $(d).attr("autocomplete", "off");
	if (v.inputClass) {
		z.addClass(v.inputClass)
	}
	var q = document.createElement("div");
	var h = $(q);
	h.hide().addClass(v.resultsClass).css("position", "absolute");
	if (v.width > 0) {
		h.css("width", v.width)
	}
	$("body").append(q);
	d.autocompleter = p;
	var I = null;
	var y = "";
	var J = -1;
	var j = {};
	var B = false;
	var l = false;
	var a = null;
	function m() {
		j = {};
		j.data = {};
		j.length = 0
	}
	m();
	if (v.data != null) {
		var t = "", O = {}, n = [];
		if (typeof v.url != "string") {
			v.cacheLength = 1
		}
		for ( var M = 0; M < v.data.length; M++) {
			n = ((typeof v.data[M] == "string") ? [ v.data[M] ] : v.data[M]);
			if (n[0].length > 0) {
				t = n[0].substring(0, 1).toLowerCase();
				if (!O[t]) {
					O[t] = []
				}
				O[t].push(n)
			}
		}
		for ( var L in O) {
			v.cacheLength++;
			e(L, O[L])
		}
	}
	z.keydown(function(k) {
		a = k.keyCode;
		switch (k.keyCode) {
		case 38:
			k.preventDefault();
			E(-1);
			break;
		case 40:
			k.preventDefault();
			E(1);
			break;
		case 9:
		case 13:
			if (G()) {
				z.get(0).blur();
				k.preventDefault()
			}
			break;
		default:
			J = -1;
			if (I) {
				clearTimeout(I)
			}
			I = setTimeout(function() {
				u()
			}, v.delay);
			break
		}
	}).focus(function() {
		l = true
	}).blur(function() {
		l = false;
		c()
	});
	w();
	function u() {
		if (a == 46 || (a > 8 && a < 32)) {
			return h.hide()
		}
		var k = z.val();
		if (k == y) {
			return
		}
		y = k;
		if (k.length >= v.minChars) {
			z.addClass(v.loadingClass);
			D(k)
		} else {
			z.removeClass(v.loadingClass);
			h.hide()
		}
	}
	function E(P) {
		var k = $("li", q);
		if (!k) {
			return
		}
		J += P;
		if (J < 0) {
			J = 0
		} else {
			if (J >= k.size()) {
				J = k.size() - 1
			}
		}
		k.removeClass("ac_over");
		$(k[J]).addClass("ac_over")
	}
	function G() {
		var k = $("li.ac_over", q)[0];
		if (!k) {
			var P = $("li", q);
			if (v.selectOnly) {
				if (P.length == 1) {
					k = P[0]
				}
			} else {
				if (v.selectFirst) {
					k = P[0]
				}
			}
		}
		if (k) {
			r(k);
			return true
		} else {
			return false
		}
	}
	function r(k) {
		if (!k) {
			k = document.createElement("li");
			k.extra = [];
			k.selectValue = ""
		}
		var P = $.trim(k.selectValue ? k.selectValue : k.innerHTML);
		d.lastSelected = P;
		y = P;
		h.html("");
		z.val(P);
		w();
		if (v.onItemSelect) {
			setTimeout(function() {
				v.onItemSelect(k)
			}, 1)
		}
	}
	function b(R, P) {
		var Q = z.get(0);
		if (Q.createTextRange) {
			var k = Q.createTextRange();
			k.collapse(true);
			k.moveStart("character", R);
			k.moveEnd("character", P);
			k.select()
		} else {
			if (Q.setSelectionRange) {
				Q.setSelectionRange(R, P)
			} else {
				if (Q.selectionStart) {
					Q.selectionStart = R;
					Q.selectionEnd = P
				}
			}
		}
		Q.focus()
	}
	function x(k) {
		if (a != 8) {
			z.val(z.val() + k.substring(y.length));
			b(y.length, k.length)
		}
	}
	function F() {
		var P = A(d);
		var k = (v.width > 0) ? v.width : z.width();
		h.css({
			width : parseInt(k) + "px",
			top : (P.y + d.offsetHeight) + "px",
			left : P.x + "px"
		}).show()
	}
	function c() {
		if (I) {
			clearTimeout(I)
		}
		I = setTimeout(w, 200)
	}
	function w() {
		if (I) {
			clearTimeout(I)
		}
		z.removeClass(v.loadingClass);
		if (h.is(":visible")) {
			h.hide()
		}
		if (v.mustMatch) {
			var k = z.val();
			if (k != d.lastSelected) {
				r(null)
			}
		}
	}
	function g(P, k) {
		if (k) {
			z.removeClass(v.loadingClass);
			q.innerHTML = "";
			if (!l || k.length == 0) {
				return w()
			}
			if ($.browser.msie) {
				h.append(document.createElement("iframe"))
			}
			q.appendChild(K(k));
			if (v.autoFill && (z.val().toLowerCase() == P.toLowerCase())) {
				x(k[0][0])
			}
			F()
		} else {
			w()
		}
	}
	function f(R) {
		if (!R) {
			return null
		}
		var k = [];
		var Q = R.split(v.lineSeparator);
		for ( var P = 0; P < Q.length; P++) {
			var S = $.trim(Q[P]);
			if (S) {
				k[k.length] = S.split(v.cellSeparator)
			}
		}
		return k
	}
	function K(U) {
		var T = document.createElement("ul");
		var R = U.length;
		if ((v.maxItemsToShow > 0) && (v.maxItemsToShow < R)) {
			R = v.maxItemsToShow
		}
		for ( var S = 0; S < R; S++) {
			var V = U[S];
			if (!V) {
				continue
			}
			var P = document.createElement("li");
			if (v.formatItem) {
				P.innerHTML = v.formatItem(V, S, R);
				P.selectValue = V[0]
			} else {
				P.innerHTML = V[0];
				P.selectValue = V[0]
			}
			var k = null;
			if (V.length > 1) {
				k = [];
				for ( var Q = 1; Q < V.length; Q++) {
					k[k.length] = V[Q]
				}
			}
			P.extra = k;
			T.appendChild(P);
			$(P).hover(function() {
				$("li", T).removeClass("ac_over");
				$(this).addClass("ac_over");
				J = $("li", T).indexOf($(this).get(0))
			}, function() {
				$(this).removeClass("ac_over")
			}).click(function(W) {
				W.preventDefault();
				W.stopPropagation();
				r(this)
			})
		}
		return T
	}
	function D(P) {
		if (!v.matchCase) {
			P = P.toLowerCase()
		}
		var k = v.cacheLength ? N(P) : null;
		if (k) {
			g(P, k)
		} else {
			if ((typeof v.url == "string") && (v.url.length > 0)) {
				$.get(o(P), function(Q) {
					Q = f(Q);
					e(P, Q);
					g(P, Q)
				})
			} else {
				z.removeClass(v.loadingClass)
			}
		}
	}
	function o(Q) {
		var k = v.url + "?q=" + encodeURI(Q);
		for ( var P in v.extraParams) {
			k += "&" + P + "=" + encodeURI(v.extraParams[P])
		}
		return k
	}
	function N(U) {
		if (!U) {
			return null
		}
		if (j.data[U]) {
			return j.data[U]
		}
		if (v.matchSubset) {
			for ( var S = U.length - 1; S >= v.minChars; S--) {
				var P = U.substr(0, S);
				var V = j.data[P];
				if (V) {
					var T = [];
					for ( var Q = 0; Q < V.length; Q++) {
						var k = V[Q];
						var R = k[0];
						if (C(R, U)) {
							T[T.length] = k
						}
					}
					return T
				}
			}
		}
		return null
	}
	function C(Q, P) {
		if (!v.matchCase) {
			Q = Q.toLowerCase()
		}
		var k = Q.indexOf(P);
		if (k == -1) {
			return false
		}
		return k == 0 || v.matchContains
	}
	this.flushCache = function() {
		m()
	};
	this.setExtraParams = function(k) {
		v.extraParams = k
	};
	this.findValue = function() {
		var P = z.val();
		if (!v.matchCase) {
			P = P.toLowerCase()
		}
		var k = v.cacheLength ? N(P) : null;
		if (k) {
			H(P, k)
		} else {
			if ((typeof v.url == "string") && (v.url.length > 0)) {
				$.get(o(P), function(Q) {
					Q = f(Q);
					e(P, Q);
					H(P, Q)
				})
			} else {
				H(P, null)
			}
		}
	};
	function H(U, T) {
		if (T) {
			z.removeClass(v.loadingClass)
		}
		var R = (T) ? T.length : 0;
		var P = null;
		for ( var S = 0; S < R; S++) {
			var V = T[S];
			if (V[0].toLowerCase() == U.toLowerCase()) {
				P = document.createElement("li");
				if (v.formatItem) {
					P.innerHTML = v.formatItem(V, S, R);
					P.selectValue = V[0]
				} else {
					P.innerHTML = V[0];
					P.selectValue = V[0]
				}
				var k = null;
				if (V.length > 1) {
					k = [];
					for ( var Q = 1; Q < V.length; Q++) {
						k[k.length] = V[Q]
					}
				}
				P.extra = k
			}
		}
		if (v.onFindValue) {
			setTimeout(function() {
				v.onFindValue(P)
			}, 1)
		}
	}
	function e(P, k) {
		if (!k || !P || !v.cacheLength) {
			return
		}
		if (!j.length || j.length > v.cacheLength) {
			m();
			j.length++
		} else {
			if (!j[P]) {
				j.length++
			}
		}
		j.data[P] = k
	}
	function A(P) {
		var Q = P.offsetLeft || 0;
		var k = P.offsetTop || 0;
		while (P = P.offsetParent) {
			Q += P.offsetLeft;
			k += P.offsetTop
		}
		return {
			x : Q,
			y : k
		}
	}
};
jQuery.fn.autocompleteP = function(b, a, c) {
	a = a || {};
	a.url = b;
	a.data = ((typeof c == "object") && (c.constructor == Array)) ? c : null;
	a.inputClass = a.inputClass || "ac_input";
	a.resultsClass = a.resultsClass || "ac_results";
	a.lineSeparator = a.lineSeparator || "\n";
	a.cellSeparator = a.cellSeparator || "|";
	a.minChars = a.minChars || 1;
	a.delay = a.delay || 400;
	a.matchCase = a.matchCase || 0;
	a.matchSubset = a.matchSubset || 1;
	a.matchContains = a.matchContains || 0;
	a.cacheLength = a.cacheLength || 1;
	a.mustMatch = a.mustMatch || 0;
	a.extraParams = a.extraParams || {};
	a.loadingClass = a.loadingClass || "ac_loading";
	a.selectFirst = a.selectFirst || false;
	a.selectOnly = a.selectOnly || false;
	a.maxItemsToShow = a.maxItemsToShow || -1;
	a.autoFill = a.autoFill || false;
	a.width = parseInt(a.width, 10) || 0;
	this.each(function() {
		var d = this;
		new jQuery.autocompleteP(d, a)
	});
	return this
};
jQuery.fn.autocompleteArray = function(b, a) {
	return this.autocomplete(null, a, b)
};
jQuery.fn.indexOf = function(b) {
	for ( var a = 0; a < this.length; a++) {
		if (this[a] == b) {
			return a
		}
	}
	return -1
};
(function($) {
	$
			.extend({
				tablesorter : new function() {
					var parsers = [], widgets = [];
					this.defaults = {
						cssHeader : "header",
						cssAsc : "headerSortUp",
						cssDesc : "headerSortDown",
						cssChildRow : "expand-child",
						cssUI : {
							widget : "ui-widget ui-widget-content ui-corner-all",
							header : "ui-widget-header ui-corner-all",
							hover : "ui-state-hover",
							icon : "ui-icon",
							iconBoth : "ui-icon-arrowthick-2-n-s",
							iconDesc : "ui-icon-arrowthick-1-n",
							iconAsc : "ui-icon-arrowthick-1-s"
						},
						sortInitialOrder : "asc",
						sortMultiSortKey : "shiftKey",
						sortForce : null,
						sortAppend : null,
						textExtraction : "simple",
						parsers : {},
						widgets : [],
						widgetZebra : {
							css : [ "even", "odd" ]
						},
						headers : {},
						widthFixed : false,
						cancelSelection : true,
						sortList : [],
						headerList : [],
						locale : "us",
						format : {
							us : {
								decimal : ".",
								date : "/"
							},
							en : {
								decimal : ".",
								date : "/"
							},
							eu : {
								decimal : ",",
								date : "."
							},
							de : {
								decimal : ",",
								date : "."
							}
						},
						onRenderHeader : null,
						selectorHeaders : "thead th",
						useUI : false,
						debug : false
					};
					function benchmark(s, d) {
						log(s + "," + (new Date().getTime() - d.getTime())
								+ "ms")
					}
					this.benchmark = benchmark;
					function log(s) {
						if (typeof console != "undefined"
								&& typeof console.debug != "undefined") {
							console.log(s)
						} else {
							alert(s)
						}
					}
					function buildParserCache(table, $headers) {
						if (table.config.debug) {
							var parsersDebug = ""
						}
						var rows = table.tBodies[0].rows;
						if (table.tBodies[0].rows[0]) {
							var list = [], cells = rows[0].cells, l = cells.length;
							for ( var i = 0; i < l; i++) {
								var p = false;
								if ($.metadata
										&& ($($headers[i]).metadata() && $(
												$headers[i]).metadata().sorter)) {
									p = getParserById($($headers[i]).metadata().sorter)
								} else {
									if ((table.config.headers[i] && table.config.headers[i].sorter)) {
										p = getParserById(table.config.headers[i].sorter)
									}
								}
								if (!p) {
									p = detectParserForColumn(table, cells[i])
								}
								if (table.config.debug) {
									parsersDebug += "column:" + i + " parser:"
											+ p.id + "\n"
								}
								list.push(p)
							}
						}
						if (table.config.debug) {
							log(parsersDebug)
						}
						return list
					}
					function detectParserForColumn(table, node) {
						var l = parsers.length;
						for ( var i = 1; i < l; i++) {
							if (parsers[i].is($.trim(getElementText(
									table.config, node)), table, node)) {
								return parsers[i]
							}
						}
						return parsers[0]
					}
					function getParserById(name) {
						var l = parsers.length;
						for ( var i = 0; i < l; i++) {
							if (parsers[i].id.toLowerCase() == name
									.toLowerCase()) {
								return parsers[i]
							}
						}
						return false
					}
					function buildCache(table) {
						if (table.config.debug) {
							var cacheTime = new Date()
						}
						var totalRows = (table.tBodies[0] && table.tBodies[0].rows.length) || 0, totalCells = (table.tBodies[0].rows[0] && table.tBodies[0].rows[0].cells.length) || 0, parsers = table.config.parsers, cache = {
							row : [],
							normalized : []
						};
						for ( var i = 0; i < totalRows; ++i) {
							var c = $(table.tBodies[0].rows[i]), cols = [];
							if (c.hasClass(table.config.cssChildRow)) {
								cache.row[cache.row.length - 1] = cache.row[cache.row.length - 1]
										.add(c);
								continue
							}
							cache.row.push(c);
							for ( var j = 0; j < totalCells; ++j) {
								cols.push(parsers[j].format(getElementText(
										table.config, c[0].cells[j]), table,
										c[0].cells[j]))
							}
							cols.push(cache.normalized.length);
							cache.normalized.push(cols);
							cols = null
						}
						if (table.config.debug) {
							benchmark("Building cache for " + totalRows
									+ " rows:", cacheTime)
						}
						return cache
					}
					function getElementText(config, node) {
						if (!node) {
							return ""
						}
						var t = "";
						if (config.textExtraction == "simple") {
							if (node.childNodes[0]
									&& node.childNodes[0].hasChildNodes()) {
								t = node.childNodes[0].innerHTML
							} else {
								t = node.innerHTML
							}
						} else {
							if (typeof (config.textExtraction) == "function") {
								t = config.textExtraction(node)
							} else {
								t = $(node).text()
							}
						}
						return t
					}
					function appendToTable(table, cache) {
						if (table.config.debug) {
							var appendTime = new Date()
						}
						var c = cache, r = c.row, n = c.normalized, totalRows = n.length, checkCell = (n[0].length - 1), tableBody = $(table.tBodies[0]), rows = [];
						for ( var i = 0; i < totalRows; i++) {
							var pos = n[i][checkCell];
							rows.push(r[pos]);
							if (!table.config.appender) {
								var o = r[pos];
								var l = o.length;
								for ( var j = 0; j < l; j++) {
									tableBody[0].appendChild(o[j])
								}
							}
						}
						if (table.config.appender) {
							table.config.appender(table, rows)
						}
						rows = null;
						if (table.config.debug) {
							benchmark("Rebuilt table:", appendTime)
						}
						applyWidget(table);
						setTimeout(function() {
							$(table).trigger("sortEnd")
						}, 0)
					}
					function buildHeaders(table) {
						if (table.config.debug) {
							var time = new Date()
						}
						var config = table.config;
						var meta = ($.metadata) ? true : false;
						$tableHeaders = $(config.selectorHeaders, table)
								.each(
										function(index) {
											this.column = index;
											this.order = formatSortingOrder(config.sortInitialOrder);
											this.count = this.order;
											if (checkHeaderMetadata(this)
													|| checkHeaderOptions(
															table, index)) {
												this.sortDisabled = true
											}
											if (!this.sortDisabled) {
												if (config.useUI) {
													$(this)
															.prepend(
																	"<span></span>")
															.children("span")
															.addClass(
																	config.cssUI.icon);
													$(this)
															.hover(
																	function() {
																		$(this)
																				.addClass(
																						config.cssUI.hover)
																	},
																	function() {
																		$(this)
																				.removeClass(
																						config.cssUI.hover)
																	})
												} else {
													if (config.onRenderHeader) {
														config.onRenderHeader
																.apply(this)
													}
												}
											}
											config.headerList[index] = this
										});
						if (table.config.debug) {
							benchmark("Built headers:", time);
							log($tableHeaders)
						}
						return $tableHeaders
					}
					function setupCss(table, $headers) {
						var c = table.config;
						if (c.useUI) {
							$(table).parent("div:first").addClass(
									c.cssUI.widget);
							$headers.addClass(c.cssUI.header);
							return [ c.cssUI.iconDesc, c.cssUI.iconAsc,
									c.cssUI.iconBoth ]
						} else {
							$headers.addClass(c.cssHeader);
							return [ c.cssDesc, c.cssAsc ]
						}
					}
					function checkCellColSpan(table, rows, row) {
						var arr = [], r = table.tHead.rows, c = r[row].cells;
						for ( var i = 0; i < c.length; i++) {
							var cell = c[i];
							if (cell.colSpan > 1) {
								arr = arr.concat(checkCellColSpan(table,
										headerArr, row++))
							} else {
								if (table.tHead.length == 1
										|| (cell.rowSpan > 1 || !r[row + 1])) {
									arr.push(cell)
								}
							}
						}
						return arr
					}
					function checkHeaderMetadata(cell) {
						if (($.metadata)
								&& ($(cell).metadata().sorter === false)) {
							return true
						}
						return false
					}
					function checkHeaderOptions(table, i) {
						if ((table.config.headers[i])
								&& (table.config.headers[i].sorter === false)) {
							return true
						}
						return false
					}
					function applyWidget(table) {
						var c = table.config.widgets;
						var l = c.length;
						for ( var i = 0; i < l; i++) {
							getWidgetById(c[i]).format(table)
						}
					}
					function getWidgetById(name) {
						var l = widgets.length;
						for ( var i = 0; i < l; i++) {
							if (widgets[i].id.toLowerCase() == name
									.toLowerCase()) {
								return widgets[i]
							}
						}
					}
					function formatSortingOrder(v) {
						if (typeof (v) != "Number") {
							return (v.toLowerCase() == "desc") ? 1 : 0
						} else {
							return (v == 1) ? 1 : 0
						}
					}
					function isValueInArray(v, a) {
						var l = a.length;
						for ( var i = 0; i < l; i++) {
							if (a[i][0] == v) {
								return true
							}
						}
						return false
					}
					function setHeadersCss(table, $headers, list, css) {
						var c = table.config;
						if (c.useUI) {
							$headers.children("span").removeClass(css[0])
									.removeClass(css[1]).addClass(css[2])
						} else {
							$headers.removeClass(css[0]).removeClass(css[1])
						}
						var h = [];
						$headers.each(function(offset) {
							if (!this.sortDisabled) {
								h[this.column] = $(this)
							}
						});
						var l = list.length;
						for ( var i = 0; i < l; i++) {
							if (c.useUI) {
								h[list[i][0]].children("span").removeClass(
										css[2]).addClass(css[list[i][1]])
							} else {
								h[list[i][0]].addClass(css[list[i][1]])
							}
						}
					}
					function fixColumnWidth(table, $headers) {
						var c = table.config;
						if (c.widthFixed) {
							var colgroup = $("<colgroup>");
							$("tr:first td", table.tBodies[0]).each(
									function() {
										colgroup.append($("<col>").css("width",
												$(this).width()))
									});
							$(table).prepend(colgroup)
						}
					}
					function updateHeaderSortCount(table, sortList) {
						var c = table.config, l = sortList.length;
						for ( var i = 0; i < l; i++) {
							var s = sortList[i], o = c.headerList[s[0]];
							o.count = s[1];
							o.count++
						}
					}
					function multisort(table, sortList, cache) {
						if (table.config.debug) {
							var sortTime = new Date()
						}
						var dynamicExp = "var sortWrapper = function(a,b) {", l = sortList.length;
						for ( var i = 0; i < l; i++) {
							var c = sortList[i][0];
							var order = sortList[i][1];
							var s = (table.config.parsers[c].type == "text") ? ((order == 0) ? makeSortFunction(
									"text", "asc", c)
									: makeSortFunction("text", "desc", c))
									: ((order == 0) ? makeSortFunction(
											"numeric", "asc", c)
											: makeSortFunction("numeric",
													"desc", c));
							var e = "e" + i;
							dynamicExp += "var " + e + " = " + s;
							dynamicExp += "if(" + e + ") { return " + e
									+ "; } ";
							dynamicExp += "else { "
						}
						var orgOrderCol = cache.normalized[0].length - 1;
						dynamicExp += "return a[" + orgOrderCol + "]-b["
								+ orgOrderCol + "];";
						for ( var i = 0; i < l; i++) {
							dynamicExp += "}; "
						}
						dynamicExp += "return 0; ";
						dynamicExp += "}; ";
						if (table.config.debug) {
							benchmark("Evaling expression:" + dynamicExp,
									new Date())
						}
						eval(dynamicExp);
						cache.normalized.sort(sortWrapper);
						if (table.config.debug) {
							benchmark("Sorting on " + sortList.toString()
									+ " and dir " + order + " time:", sortTime)
						}
						return cache
					}
					function makeSortFunction(type, direction, index) {
						var a = "a[" + index + "]", b = "b[" + index + "]";
						if (type == "text" && direction == "asc") {
							return "("
									+ a
									+ " == "
									+ b
									+ " ? 0 : ("
									+ a
									+ " === null ? Number.POSITIVE_INFINITY : ("
									+ b
									+ " === null ? Number.NEGATIVE_INFINITY : ("
									+ a + " < " + b + ") ? -1 : 1 )));"
						} else {
							if (type == "text" && direction == "desc") {
								return "("
										+ a
										+ " == "
										+ b
										+ " ? 0 : ("
										+ a
										+ " === null ? Number.POSITIVE_INFINITY : ("
										+ b
										+ " === null ? Number.NEGATIVE_INFINITY : ("
										+ b + " < " + a + ") ? -1 : 1 )));"
							} else {
								if (type == "numeric" && direction == "asc") {
									return "("
											+ a
											+ " === null && "
											+ b
											+ " === null) ? 0 :("
											+ a
											+ " === null ? Number.POSITIVE_INFINITY : ("
											+ b
											+ " === null ? Number.NEGATIVE_INFINITY : "
											+ a + " - " + b + "));"
								} else {
									if (type == "numeric"
											&& direction == "desc") {
										return "("
												+ a
												+ " === null && "
												+ b
												+ " === null) ? 0 :("
												+ a
												+ " === null ? Number.POSITIVE_INFINITY : ("
												+ b
												+ " === null ? Number.NEGATIVE_INFINITY : "
												+ b + " - " + a + "));"
									}
								}
							}
						}
					}
					function makeSortText(i) {
						return "((a[" + i + "] < b[" + i + "]) ? -1 : ((a[" + i
								+ "] > b[" + i + "]) ? 1 : 0));"
					}
					function makeSortTextDesc(i) {
						return "((b[" + i + "] < a[" + i + "]) ? -1 : ((b[" + i
								+ "] > a[" + i + "]) ? 1 : 0));"
					}
					function makeSortNumeric(i) {
						return "a[" + i + "]-b[" + i + "];"
					}
					function makeSortNumericDesc(i) {
						return "b[" + i + "]-a[" + i + "];"
					}
					function sortText(a, b) {
						return ((a < b) ? -1 : ((a > b) ? 1 : 0))
					}
					function sortTextDesc(a, b) {
						return ((b < a) ? -1 : ((b > a) ? 1 : 0))
					}
					function sortNumeric(a, b) {
						return a - b
					}
					function sortNumericDesc(a, b) {
						return b - a
					}
					function getCachedSortType(parsers, i) {
						return parsers[i].type
					}
					this.construct = function(settings) {
						return this
								.each(function() {
									if (!this.tHead || !this.tBodies) {
										return
									}
									var $this, $document, $headers, cache, config, shiftDown = 0, sortOrder;
									this.config = {};
									config = $.extend(this.config,
											$.tablesorter.defaults, settings);
									$this = $(this);
									$.data(this, "tablesorter", config);
									$headers = buildHeaders(this);
									this.config.parsers = buildParserCache(
											this, $headers);
									cache = buildCache(this);
									var sortCSS = setupCss(this, $headers);
									fixColumnWidth(this);
									$headers
											.click(
													function(e) {
														var totalRows = ($this[0].tBodies[0] && $this[0].tBodies[0].rows.length) || 0;
														if (!this.sortDisabled
																&& totalRows > 0) {
															$this
																	.trigger("sortStart");
															var $cell = $(this);
															var i = this.column;
															this.order = this.count++ % 2;
															if (!e[config.sortMultiSortKey]) {
																config.sortList = [];
																if (config.sortForce != null) {
																	var a = config.sortForce;
																	for ( var j = 0; j < a.length; j++) {
																		if (a[j][0] != i) {
																			config.sortList
																					.push(a[j])
																		}
																	}
																}
																config.sortList
																		.push([
																				i,
																				this.order ])
															} else {
																if (isValueInArray(
																		i,
																		config.sortList)) {
																	for ( var j = 0; j < config.sortList.length; j++) {
																		var s = config.sortList[j], o = config.headerList[s[0]];
																		if (s[0] == i) {
																			o.count = s[1];
																			o.count++;
																			s[1] = o.count % 2
																		}
																	}
																} else {
																	config.sortList
																			.push([
																					i,
																					this.order ])
																}
															}
															setTimeout(
																	function() {
																		setHeadersCss(
																				$this[0],
																				$headers,
																				config.sortList,
																				sortCSS);
																		appendToTable(
																				$this[0],
																				multisort(
																						$this[0],
																						config.sortList,
																						cache))
																	}, 1);
															return false
														}
													})
											.mousedown(
													function() {
														if (config.cancelSelection) {
															this.onselectstart = function() {
																return false
															};
															return false
														}
													});
									$this
											.bind(
													"update",
													function() {
														var me = this;
														setTimeout(
																function() {
																	me.config.parsers = buildParserCache(
																			me,
																			$headers);
																	cache = buildCache(me)
																}, 1)
													})
											.bind(
													"updateCell",
													function(e, cell) {
														var config = this.config;
														var pos = [
																(cell.parentNode.rowIndex - 1),
																cell.cellIndex ];
														cache.normalized[pos[0]][pos[1]] = config.parsers[pos[1]]
																.format(
																		getElementText(
																				config,
																				cell),
																		cell)
													})
											.bind(
													"sorton",
													function(e, list) {
														$(this).trigger(
																"sortStart");
														config.sortList = list;
														var sortList = config.sortList;
														updateHeaderSortCount(
																this, sortList);
														setHeadersCss(this,
																$headers,
																sortList,
																sortCSS);
														appendToTable(
																this,
																multisort(
																		this,
																		sortList,
																		cache))
													}).bind(
													"appendCache",
													function() {
														appendToTable(this,
																cache)
													}).bind(
													"applyWidgetId",
													function(e, id) {
														getWidgetById(id)
																.format(this)
													}).bind("applyWidgets",
													function() {
														applyWidget(this)
													});
									if ($.metadata
											&& ($(this).metadata() && $(this)
													.metadata().sortlist)) {
										config.sortList = $(this).metadata().sortlist
									}
									if (config.sortList.length > 0) {
										$this.trigger("sorton",
												[ config.sortList ])
									} else {
										applyWidget(this)
									}
								})
					};
					this.addParser = function(parser) {
						var l = parsers.length, a = true;
						for ( var i = 0; i < l; i++) {
							if (parsers[i].id.toLowerCase() == parser.id
									.toLowerCase()) {
								a = false
							}
						}
						if (a) {
							parsers.push(parser)
						}
					};
					this.addWidget = function(widget) {
						widgets.push(widget)
					};
					this.formatDate = function(s, config) {
						if (config.locale != "us") {
							var datePoint = "\\"
									+ config.format[config.locale]["date"];
							s = s.replace(new RegExp("[\\-" + datePoint + "]",
									"g"), config.format.us["date"])
						}
						return s
					};
					this.formatDecimal = function(s, config) {
						if (config.locale != "us") {
							s = s.replace(
									config.format[config.locale]["decimal"],
									config.format.us["decimal"])
						}
						return s
					};
					this.formatFloat = function(s) {
						var i = parseFloat(s);
						return (isNaN(i)) ? 0 : i
					};
					this.formatInt = function(s) {
						var i = parseInt(s);
						return (isNaN(i)) ? 0 : i
					};
					this.isDigit = function(s, config) {
						var decimalPoint = "\\"
								+ config.format[config.locale]["decimal"];
						var exp = "/(^[+]?0("
								+ decimalPoint
								+ "0+)?$)|(^([-+]?[0-9]*)$)|(^([-+]?((0?[0-9]*)"
								+ decimalPoint + "(0*[0-9]*)))$)|(^[-+]?[0-9]*"
								+ decimalPoint + "0+$)/";
						return RegExp(exp).test($.trim(s))
					};
					this.clearTableBody = function(table) {
						if ($.browser.msie) {
							function empty() {
								while (this.firstChild) {
									this.removeChild(this.firstChild)
								}
							}
							empty.apply(table.tBodies[0])
						} else {
							table.tBodies[0].innerHTML = ""
						}
					}
				}
			});
	$.fn.extend({
		tablesorter : $.tablesorter.construct
	});
	var ts = $.tablesorter;
	ts.addParser({
		id : "text",
		is : function(s) {
			return true
		},
		format : function(s) {
			return $.trim(s.toLowerCase())
		},
		type : "text"
	});
	ts.addParser({
		id : "digit",
		is : function(s, table) {
			var c = table.config;
			return $.tablesorter.isDigit(s, c)
		},
		format : function(s, table) {
			var c = table.config;
			s = $.tablesorter.formatDecimal(s, c);
			return $.tablesorter.formatFloat(s)
		},
		type : "numeric"
	});
	ts.addParser({
		id : "currency",
		is : function(s) {
			return /^[Â£$â‚¬?.,]/.test(s)
		},
		format : function(s, table) {
			var c = table.config;
			s = $.tablesorter.formatDecimal(s, c);
			return $.tablesorter.formatFloat(s.replace(new RegExp(/[Â£$â‚¬]/g),
					""))
		},
		type : "numeric"
	});
	ts.addParser({
		id : "ipAddress",
		is : function(s) {
			return /^\d{2,3}[\.]\d{1,3}[\.]\d{1,3}[\.]\d{1,3}$/.test(s)
		},
		format : function(s) {
			var a = s.split("."), r = "", l = a.length;
			for ( var i = 0; i < l; i++) {
				var item = a[i];
				if (item.length == 2) {
					r += "0" + item
				} else {
					r += item
				}
			}
			return $.tablesorter.formatFloat(r)
		},
		type : "numeric"
	});
	ts.addParser({
		id : "url",
		is : function(s) {
			return /^(https?|ftp|file):\/\/$/.test(s)
		},
		format : function(s) {
			return jQuery.trim(s.replace(new RegExp(/(https?|ftp|file):\/\//),
					""))
		},
		type : "text"
	});
	ts.addParser({
		id : "isoDate",
		is : function(s) {
			return /^\d{4}[\/-]\d{1,2}[\/-]\d{1,2}$/.test(s)
		},
		format : function(s) {
			return $.tablesorter.formatFloat((s != "") ? new Date(s.replace(
					new RegExp(/-/g), "/")).getTime() : "0")
		},
		type : "numeric"
	});
	ts.addParser({
		id : "percent",
		is : function(s) {
			return /\%$/.test($.trim(s))
		},
		format : function(s, table) {
			var c = table.config;
			s = $.tablesorter.formatDecimal(s, c);
			return $.tablesorter.formatFloat(s.replace(new RegExp(/%/g), ""))
		},
		type : "numeric"
	});
	ts
			.addParser({
				id : "usLongDate",
				is : function(s) {
					return s
							.match(new RegExp(
									/^[A-Za-z]{3,10}\.? [0-9]{1,2}, ([0-9]{4}|'?[0-9]{2}) (([0-2]?[0-9]:[0-5][0-9])|([0-1]?[0-9]:[0-5][0-9]\s(AM|PM)))$/))
				},
				format : function(s) {
					return $.tablesorter.formatFloat(new Date(s).getTime())
				},
				type : "numeric"
			});
	ts.addParser({
		id : "mediumDate",
		is : function(s, table) {
			var c = table.config;
			var datePoint = "\\" + c.format[c.locale]["date"];
			var expStr = "\\d{1,2}[\\-" + datePoint + "]\\d{1,2}[\\-"
					+ datePoint + "]\\d{4}";
			return RegExp(expStr).test(s)
		},
		format : function(s, table) {
			var c = table.config;
			s = $.tablesorter.formatDate(s, c);
			if (c.locale == "us") {
				s = s.replace(/(\d{1,2})[\/](\d{1,2})[\/](\d{4})/, "$3/$1/$2")
			} else {
				if (c.locale == "en" || c.locale == "de" || c.locale == "eu") {
					s = s.replace(/(\d{1,2})[\/](\d{1,2})[\/](\d{4})/,
							"$3/$2/$1")
				}
			}
			return $.tablesorter.formatFloat((s != "") ? new Date(s).getTime()
					: 0)
		},
		type : "numeric"
	});
	ts.addParser({
		id : "shortDate",
		is : function(s, table) {
			var c = table.config;
			var datePoint = "\\" + c.format[c.locale]["date"];
			var expStr = "\\d{1,2}[\\-" + datePoint + "]\\d{1,2}[\\-"
					+ datePoint + "]\\d{2}";
			return RegExp(expStr).test(s)
		},
		format : function(s, table) {
			var c = table.config;
			s = $.tablesorter.formatDate(s, c);
			if (c.locale == "us") {
				s = s.replace(/(\d{1,2})[\/](\d{1,2})[\/](\d{2})/, "$1/$2/$3")
			} else {
				if (c.locale == "en" || c.locale == "de" || c.locale == "eu") {
					s = s.replace(/(\d{1,2})[\/](\d{1,2})[\/](\d{2})/,
							"$2/$1/$3")
				}
			}
			return $.tablesorter.formatFloat((s != "") ? new Date(s).getTime()
					: 0)
		},
		type : "numeric"
	});
	ts
			.addParser({
				id : "time",
				is : function(s) {
					return /^(([0-2]?[0-9]:[0-5][0-9])|([0-1]?[0-9]:[0-5][0-9]\s(am|pm)))$/
							.test(s)
				},
				format : function(s) {
					return $.tablesorter
							.formatFloat(new Date("2000/01/01 " + s).getTime())
				},
				type : "numeric"
			});
	ts.addParser({
		id : "metadata",
		is : function(s) {
			return false
		},
		format : function(s, table, cell) {
			var c = table.config, p = (!c.parserMetadataName) ? "sortValue"
					: c.parserMetadataName;
			return $(cell).metadata()[p]
		},
		type : "numeric"
	});
	ts.addWidget({
		id : "zebra",
		format : function(table) {
			if (table.config.debug) {
				var time = new Date()
			}
			var $tr, row = -1, odd;
			$("tr:visible", table.tBodies[0]).each(
					function(i) {
						$tr = $(this);
						if (!$tr.hasClass(table.config.cssChildRow)) {
							row++
						}
						odd = (row % 2 == 0);
						$tr.removeClass(
								table.config.widgetZebra.css[odd ? 0 : 1])
								.addClass(
										table.config.widgetZebra.css[odd ? 1
												: 0])
					});
			if (table.config.debug) {
				$.tablesorter.benchmark("Applying Zebra widget", time)
			}
		}
	})
})(jQuery);
function prettyDate(d) {
	var b = new Date((d || "").replace(/-/g, "/"));
	var c = (((new Date()).getTime() - b.getTime()) / 1000);
	var a = Math.floor(c / 86400);
	if (isNaN(a) || a < 0 || a >= 31) {
		return
	}
	return a == 0
			&& (c < 60 && "just now" || c < 120 && "1 minute ago" || c < 3600
					&& Math.floor(c / 60) + " minutes ago" || c < 7200
					&& "1 hour ago" || c < 86400 && Math.floor(c / 3600)
					+ " hours ago") || a == 1 && "Yesterday" || a < 7 && a
			+ " days ago" || a < 14 && "1 week ago" || a < 31
			&& Math.ceil(a / 7) + " weeks ago"
}
if (typeof jQuery != "undefined") {
	jQuery.fn.prettyDate = function() {
		return this.each(function() {
			var a = prettyDate(this.title);
			if (a) {
				jQuery(this).text(a)
			}
		})
	}
}
$(document).ready(function init() {
	$.each(Init, function(a, b) {
		b()
	})
});
var Init = {
	enforceMinHeight : function() {
		var c = 450;
		var f = document.getElementById("sideColumn");
		var e = document.getElementById("sideColumnShow");
		var d = document.getElementById("sideColumnHide");
		var a = document.getElementById("main");
		if (a) {
			var b = (a.offsetHeight > c) ? a.offsetHeight : c;
			if (f) {
				f.style.minHeight = b + "px"
			}
			if (e) {
				e.style.minHeight = b + "px"
			}
			if (d) {
				d.style.minHeight = b + "px"
			}
		}
	},
	largeOverlay : function() {
		$("#jqm_large_overlay").jqm(
				{
					ajax : "@href",
					target : ".jqmTarget",
					trigger : ".largeOverlayLink",
					onLoad : function(b) {
						var a = $(window).height()
								- (parseInt(b.w.css("top")) * 2) - 20;
						b.w.find(".jqmTarget").css({
							height : a + "px",
							overflowY : "auto"
						})
					},
					onShow : function(b) {
						b.w.find(".jqmTitle").html(b.t.title).end().fadeIn();
						var a = document.getElementById("hidefooter");
						if (a != null) {
							b.w.find(".jqmFooter").css({
								display : "none"
							})
						}
						return true
					},
					onHide : function(a) {
						a.w.hide();
						a.o.fadeOut()
					}
				})
	},
	dialog : function() {
		$("#jqm_dialog").jqm({
			trigger : ".dialogLink",
			modal : true,
			onShow : function(a) {
				a.w.fadeIn()
			},
			onHide : function(a) {
				a.w.hide();
				a.o.fadeOut()
			}
		})
	},
	accordian : function() {
		$(".vAccordion button.tab").click(function() {
			var a = $(this).next().is(":visible");
			setUiState(this.id, a ? "hidden" : "visible");
			$(this).children(".expCol").html(a ? "+" : "-");
			$(this).next().slideToggle("fast");
			return false
		}).hoverClass("hover")
	},
	side_nav : function() {
		$(".side_nav").click(function() {
			var a = $("#sideColumn").is(":visible");
			setUiState("side_nav", a ? "hidden" : "visible");
			if (a) {
				$("#sideColumn").toggle("fast", function() {
					$(".main .content").css("width", "961px");
					$("#sideColumnShow").attr("id", "sideColumnHide");
					$("#sideColumnHide").attr("title", "show side navigation")
				})
			} else {
				$(".main .content").css("width", "759px");
				$("#sideColumnHide").attr("id", "sideColumnShow");
				$("#sideColumnShow").attr("title", "hide side navigation");
				$("#sideColumn").toggle("fast")
			}
			return false
		}).hoverClass("hover")
	},
	popups : function() {
		$("body").click(function() {
			$("#contextMenu:visible,#contextMenuShadow:visible").hide()
		});
		$(".contextMenuAnchor").livequery("click", function(a) {
			a.preventDefault();
			a.stopPropagation();
			$menu = $("#contextMenu");
			var c = $(a.target).offset();
			var b = ($(this).is("a") ? this.id : this.parentNode.id);
			c.top += 18;
			c.left -= 8;
			$("#contextMenuBody").html($("#" + b + "_content").html());
			$menu.css({
				top : c.top,
				left : c.left
			}).click(function(d) {
				d.stopPropagation()
			}).show();
			$("#contextMenuShadow").css({
				top : c.top + 2,
				left : c.left + 2,
				width : $menu.outerWidth(),
				height : $menu.outerHeight()
			}).click(function(d) {
				d.stopPropagation()
			}).show();
			$menu.triggerHandler("show")
		})
	},
	notImplemented : function() {
		$(".notImplemented").click(
				function(a) {
					a.preventDefault();
					var c = $(a.target).offset();
					var b = $("<div></div>").css({
						top : c.top + "px",
						left : c.left + "px"
					}).attr("className", "not-implemented-notice").html(
							"Not yet implemented");
					$(document.body).append(b);
					$(b).animate({
						opacity : 1
					}, 1000).fadeOut(2000)
				})
	},
	highlightTextFields : function() {
		$(".textInput").focus(function() {
			$(this).addClass("focused")
		}).blur(function() {
			$(this).removeClass("focused")
		})
	},
	tagHelpers : function() {
		if (page.project_tags) {
			$("input#project_tag_list").tagSuggest({
				tags : page.project_tags,
				sort : false
			})
		}
		if (page.person_tags) {
			$("input#person_tag_list").tagSuggest({
				tags : page.person_tags,
				sort : false
			})
		}
	},
	projectAutocomplete : function() {
		$(".project-autocomplete").livequery(function() {
			$(this).autocompleteP("/projects/autocomplete", {
				delay : 100,
				minChars : 1,
				matchSubset : 0,
				matchContains : 0,
				cacheLength : 10,
				mustMatch : 0,
				onItemSelect : ProjectAutocomplete.findValue,
				onFindValue : ProjectAutocomplete.findValue,
				formatItem : ProjectAutocomplete.format,
				selectFirst : true,
				autoFill : true
			});
			$(".project-toggle-edit").toggleEdit()
		})
	},
	personAutocomplete : function() {
		$(".person-autocomplete").livequery(function() {
			$(this).autocompleteP("/people/autocomplete", {
				delay : 100,
				minChars : 3,
				matchSubset : 0,
				matchContains : 0,
				cacheLength : 10,
				mustMatch : 0,
				onItemSelect : PersonAutocomplete.findValue,
				onFindValue : PersonAutocomplete.findValue,
				formatItem : PersonAutocomplete.format,
				selectFirst : true,
				autoFill : true
			});
			$(".person-toggle-edit").toggleEdit()
		})
	},
	liveSearch : function() {
		$("#live-search").focus(function() {
			if (this.value == "Jump to...") {
				this.value = ""
			}
		});
		$("#live-search").blur(function() {
			if (this.value == "") {
				this.value = "Jump to..."
			}
		});
		$("#live-search").autocomplete(
				{
					ajax : "/home/live_lookup",
					timeout : 30,
					anchor : "#jq-ui-autocomplete-parent",
					match : function(a) {
						return this.url
								.match(new RegExp("/projects/" + a, "i"))
								|| this.name.match(new RegExp("^" + a, "i"))
					},
					insertText : function(a) {
						return a.name
					},
					template : function(a) {
						var b = a.image_url == "" ? "" : "<img src='"
								+ a.image_url + "' width='20' height='20' />";
						s = "<li><div class='ival'>" + a.name
								+ "<br /><span class='type'>(" + a.t
								+ ")</span></div>" + b
								+ "<span style='clear:both'></span></li>";
						return s
					}
				}).bind("activate.autocomplete", function(a, b) {
			if (b) {
				window.location = b.url
			}
		}).bind("cancel.autocomplete", function(a) {
		})
	},
	inlineFormTables : function() {
		$(".ift").inlineFormTable();
		$(".ift-new").show()
	},
	permissionsTable : function() {
		if (page.init_permissions_table) {
			$("#permissions-table").click(
					function(d) {
						$e = $(d.target);
						if ($e.is(":checkbox")) {
							var f = $e.attr("id").split("_")[1];
							var g = f.split("-")[0];
							var c = f.split("-")[1];
							var a = "/projects/" + page.project_name
									+ "/features/" + page.feature_id
									+ "/permissions/";
							var b = ($e.is(":checked") ? ""
									: "delete_by_role_and_activity");
							$.post(a + b, {
								"permission[role_id]" : g,
								"permission[activity_id]" : c,
								authenticity_token : page.token
							}, function(e) {
								$("#update-notice").show();
								$("#update-list").prepend("<li>" + e + "</li>")
										.find("li:first").css("background",
												"#ffff00").animate({
											backgroundColor : "#ffffff"
										}, 1500)
							}, "text")
						}
					})
		}
	},
	servicesTable : function() {
		if (page.init_services_table) {
			$("#services-table").click(
					function(b) {
						$e = $(b.target);
						if ($e.is(":checkbox")) {
							var a = $e.attr("id").split("_")[1];
							$.post("/admin/services/" + a, {
								show : $e.is(":checked") ? 1 : 0,
								_method : "put",
								authenticity_token : page.token
							}, function(c) {
								$("#update-notice").show();
								$("#update-list").prepend("<li>" + c + "</li>")
										.find("li:first").css("background",
												"#ffff00").animate({
											backgroundColor : "#ffffff"
										}, 1500)
							}, "text")
						}
					})
		}
	},
	linksTable : function() {
		if (page.init_links_table) {
			$("table.admin").livequery(function() {
				$(this).tableDnD({
					onDrop : function(b, d) {
						var c = b.tBodies[0].rows;
						for ( var a = 0; a < c.length; a++) {
							if (c[a].id == d.id) {
								break
							}
						}
						$.post(page.init_links_table, {
							id : d.id,
							new_position : (a + 1),
							authenticity_token : page.token
						})
					}
				})
			})
		}
	},
	revisionLoader : function() {
		$("a.content-link").add("a.diff-link").click(function() {
			var b = $(this).parents(".change");
			var a = this.href;
			$(".loading").show();
			$(".content", b).load(a, null, function() {
				SyntaxHighlighter.all();
				dp.SyntaxHighlighter.HighlightAll("code", true, false, false)
			});
			$(".loading").hide();
			return false
		}).add("a.rev-link").each(function() {
			this.href = this.href.replace(/%2F/gi, "/").replace(/ /g, "%20")
		})
	},
	tigerTableLoader : function() {
		$("table.tigerTable tbody tr:even").addClass("altRowColor");
		$("table.tigerTable tbody tr:odd").addClass("rowColor")
	},
	prettyDateLoader : function() {
		$(".pretty-date").prettyDate()
	},
	inplaceLogin : function() {
		$(".inplaceLoginForm")
				.livequery(
						function() {
							var a = this;
							$("#contextMenu")
									.bind(
											"show",
											function() {
												$(
														'.inplaceLoginForm:last input[type="text"]:first')
														.focus()
											});
							$(a)
									.ajaxForm(
											{
												beforeSubmit : function(c, d, b) {
													$(".spinner").show()
												},
												success : function(b) {
													$(".spinner").hide();
													$(
															"#contextMenu:visible,#contextMenuShadow:visible")
															.hide();
													$(".controls")
															.html(b)
															.css("background",
																	"#ffff00")
															.animate(
																	{
																		backgroundColor : "#eeeeee"
																	},
																	1000,
																	null,
																	function() {
																		$(this)
																				.css(
																						"background",
																						null)
																	})
												},
												error : function(d, b, c) {
													$("#contextMenuBody").html(
															d.responseText);
													$("#contextMenu")
															.triggerHandler(
																	"show")
												}
											});
							$(".inplaceLoginForm .cancel")
									.click(
											function(b) {
												b.preventDefault();
												b.stopPropagation();
												$(
														"#contextMenu:visible,#contextMenuShadow:visible")
														.hide()
											})
						})
	}
};
$.ajaxSetup({
	data : {
		authenticity_token : page.token
	}
});
ProjectAutocomplete = {
	findValue : function(a) {
		var b = a.extra[0];
		$.get("/widgets/project_snippit", {
			id : b
		}, function(c) {
			$(".project-toggle-edit").trigger("setContent.toggleEdit", [ c ])
		})
	},
	format : function(c, a, b) {
		return '<img src="' + c[2] + '" width="20" height="20" />&nbsp;' + c[0]
	}
};
PersonAutocomplete = {
	findValue : function(a) {
		var b = a.extra[0];
		$.get("/widgets/person_snippit", {
			id : b
		}, function(c) {
			$(".person-toggle-edit").trigger("setContent.toggleEdit", [ c ])
		})
	},
	format : function(c, a, b) {
		return "<div class='ival'><img src='" + c[2]
				+ "' width='20' height='20' />" + c[0]
				+ "<br /><span class='type'>(" + c[3]
				+ ")</span></div><span style='clear:both'></span>"
	}
};
function initWikiPageToc() {
	$("#toctitle").html(
			'Contents [<a id="toctoggle" class="toc-toggle">hide</a>]');
	$("#toctoggle").bind("click", function(a) {
		if ($("#toctoggle").text() == "hide") {
			$("#toccontents").hide();
			$("#toctoggle").text("show")
		} else {
			$("#toccontents").show();
			$("#toctoggle").text("hide")
		}
	})
}
function initWikiPagePreformattedBlocks() {
	$("pre").each(function(a) {
		if (this.scrollWidth <= this.offsetWidth) {
			this.style.overflow = "hidden"
		}
	})
}
function initWikiPageSyntaxHighlight() {
	SyntaxHighlighter.all();
	dp.SyntaxHighlighter.HighlightAll("code", true, false, false)
}
function initWikiAccordionPageCreate() {
	$("#wiki_page_create_submit").click(function(a) {
		id = $("#wiki_page_create_id").attr("value");
		if (id.length < 1) {
			div = $("#wiki_page_create_errors");
			div.hide();
			div.text("Enter a name for the wiki page");
			div.slideDown("normal");
			a.preventDefault()
		}
		if (id.indexOf("/") > 0 || id.indexOf(".") > 0 || id.indexOf("?") > 0) {
			div = $("#wiki_page_create_errors");
			div.hide();
			div.text("Name must not contain '/', '.', or '?'");
			div.slideDown("normal");
			a.preventDefault()
		} else {
			id = encodeURIComponent(id).replace(".", "%2E");
			edit_path = $("#wiki_page_create_path").attr("value");
			edit_path = edit_path.replace("_id_", id);
			$("#wiki_page_create").attr("action", edit_path)
		}
	})
}
function initScmSyntaxHighlight() {
	SyntaxHighlighter.all();
	dp.SyntaxHighlighter.HighlightAll("code", true, false, false)
}
function loadScmHistory(c, b) {
	var a = "Loading...";
	$("table#fileListing tr.waitmsg:first-child td:nth-child(2)").html(a);
	$.each(b, function() {
		var e = this[0];
		var d = this[1];
		$.get(c + "/" + d, null, function(f) {
			$("#" + e).html(f)
		})
	})
}
$.fn.populateIDFrom = function(a) {
	return this.each(function() {
		var b = $(this);
		b.focus(function() {
			if (b.val() == "") {
				b.val($(a).val().toLowerCase().replace(/[^a-z0-9]+/g, "-"))
			}
		})
	})
};
function setUiState(a, b) {
	$.post("/home/set_state", {
		key : a,
		value : b,
		authenticity_token : page.token
	})
}
function getUiState(a) {
	$.get("/home/get_state", {
		key : a,
		authenticity_token : page.token
	}, function(b) {
		if (b == "hidden") {
			$(".main .content").css("width", "961px")
		}
		if (b == "visible") {
			$(".main .content").css("width", "759px")
		}
	})
}
Modal = {
	show : function(d, c, a, b) {
		$("#jqm_dialog").find(".jqmTitle").html(d).end().find(".jqmTarget")
				.html(c).end().jqmShow();
		Modal.yes = a;
		if (b != false) {
			Modal.no = b
		}
	},
	yes : null,
	no : null
};