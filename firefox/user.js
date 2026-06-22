/** PASSWORDS / AUTOFILL ***/
user_pref("signon.rememberSignons", false);
user_pref("signon.management.page.breach-alerts.enabled", false);
user_pref("signon.autofillForms", false);
user_pref("signon.generation.enabled", false);
user_pref("signon.firefoxRelay.feature", "");
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);

/** UI ***/
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true); // enable userChrome.css
user_pref("browser.toolbars.bookmarks.visibility", "never");
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.aboutwelcome.enabled", false);
user_pref("browser.tabs.loadBookmarksInTabs", true);
user_pref("browser.zoom.full", false); // text-only zoom
user_pref("browser.bookmarks.max_backups", 0);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
user_pref("ui.key.menuAccessKey", 0);
user_pref("ui.SpellCheckerUnderlineStyle", 1);
user_pref("general.autoScroll", false);
user_pref("layout.word_select.eat_space_to_next_word", false);
user_pref("view_source.wrap_long_lines", true);
user_pref("devtools.debugger.ui.editor-wrapping", true);
user_pref("devtools.accessibility.enabled", false);
user_pref("reader.parse-on-load.enabled", false);
user_pref("accessibility.force_disabled", 1);
user_pref("pdfjs.defaultZoomValue", "page-width");
user_pref("app.update.auto", false);

/** URL BAR ***/
user_pref("browser.urlbar.suggest.history", false);
user_pref("browser.urlbar.suggest.bookmark", true);
user_pref("browser.urlbar.suggest.openpage", false);
user_pref("browser.urlbar.suggest.topsites", false);
user_pref("browser.urlbar.suggest.engines", false);
user_pref("browser.urlbar.suggest.recentsearches", false);
user_pref("browser.urlbar.showSearchSuggestionsFirst", false);
user_pref("browser.urlbar.quicksuggest.enabled", false);
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
user_pref("browser.urlbar.groupLabels.enabled", false);
user_pref("browser.search.update", false);
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.formfill.enable", false);

/** NEW TAB ***/
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeBookmarks", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeDownloads", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeVisited", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);

/** MOZILLA BLOAT ***/
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.preferences.moreFromMozilla", false);
user_pref("browser.firefox-view.feature-tour", "{\"screen\":\"\",\"complete\":true}");

/** NEW TAB - hide everything ***/
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.showSearch", false);
user_pref("browser.newtabpage.activity-stream.showWeather", false);
user_pref("browser.newtabpage.activity-stream.system.showWeather", false);
user_pref("browser.newtabpage.activity-stream.feeds.weatherfeed", false);
user_pref("browser.newtabpage.activity-stream.logowordmark.alwaysVisible", false);
user_pref("browser.newtabpage.activity-stream.newtabWallpapers.enabled", false);
user_pref("browser.newtabpage.activity-stream.newtabWallpapers.v2.enabled", false);
user_pref("browser.newtabpage.activity-stream.showSections", false);

/** ANIMATIONS ***/
user_pref("ui.prefersReducedMotion", 1);
user_pref("browser.tabs.animate", false);
user_pref("full-screen-api.transition-duration.enter", "0 0");
user_pref("full-screen-api.transition-duration.leave", "0 0");
user_pref("full-screen-api.warning.timeout", 0);

/** AI ***/
user_pref("browser.ai.control.default", "blocked");
user_pref("browser.ml.enable", false);
user_pref("browser.ml.chat.enabled", false);
user_pref("browser.ml.chat.menu", false);
user_pref("browser.tabs.groups.smart.enabled", false);
user_pref("browser.ml.linkPreview.enabled", false);
