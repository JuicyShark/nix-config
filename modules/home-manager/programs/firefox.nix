{ pkgs, config, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.juicy = {
      isDefault = true;
      name = "juicy";
      search = {
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nix" ];
          };
          "YT" = {
            urls = [{
              template = "https://www.youtube.com/results?search_query={searchTerms}";
            }];
            iconUpdateURL = "https://www.youtube.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@yt" ];
          };
          "Google" = {
            urls = [{
              template = "http://google.com.au/search?q={searchTerms}";
            }];
            iconUpdateURL = "http://google.com.au/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@g" ];
          };
        };
        force = true;
        default = "Google";
      };


      settings = {
        /****************************************************************************
                                                                                                                                                                                                                                				 * Betterfox                                                                *
                                                                                                                                                                                                                                				 * "Ad meliora"                                                             *
                                                                                                                                                                                                                                				 * version: 115                                                             *
                                                                                                                                                                                                                                				 * url: https://github.com/yokoffing/Betterfox                              *
                                                                                                                                                                                    				****************************************************************************/

        /****************************************************************************
                                                                                                                                                                                                                                				 * SECTION: FASTFOX                                                         *
                                                                                                                                                                                    				****************************************************************************/
        "nglayout.initialpaint.delay" = 5;
        "nglayout.initialpaint.delay_in_oopif" = 0;
        "content.notify.interval" = 100000;
        "browser.startup.preXulSkeletonUI" = false;

        /** EXPERIMENTAL ***/
        "layout.css.grid-template-masonry-value.enabled" = true;
        "dom.enable_web_task_scheduling" = true;

        /** GFX ***/
        "gfx.webrender.all" = true;
        "gfx.webrender.precache-shaders" = true;
        "gfx.webrender.compositor" = true;
        "layers.gpu-process.enabled" = true;
        "media.hardware-video-decoding.enabled" = true;
        "gfx.canvas.accelerated" = true;
        "gfx.canvas.accelerated.cache-items" = 8192;
        "gfx.canvas.accelerated.cache-size" = 2056;
        "gfx.content.skia-font-cache-size" = 20;
        "image.cache.size" = 10485760;
        "image.mem.decode_bytes_at_a_time" = 131072;
        "image.mem.shared.unmap.min_expiration_ms" = 120000;
        "media.memory_cache_max_size" = 1048576;
        "media.memory_caches_combined_limit_kb" = 2560000;
        "media.cache_readahead_limit" = 9000;
        "media.cache_resume_threshold" = 6000;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.av1.enabled" = false;
        /** BROWSER CACHE **/
        "browser.cache.disk.smart_size.enabled" = false;
        "browser.cache.disk.capacity" = 1024000;
        "browser.cache.disk.max_entry_size" = 102400;
        "browser.cache.memory.max_entry_size" = 153600;
        "browser.cache.disk.metadata_memory_limit" = 1000;
        "browser.cache.memory.capacity" = 4194304;
        "browser.sessionhistory.max_total_viewers" = 2;

        /** NETWORK ***/
        "network.buffer.cache.size" = 262144;
        "network.buffer.cache.count" = 128;
        "network.http.max-connections" = 2400;
        "network.http.max-persistent-connections-per-server" = 10;
        "network.ssl_tokens_cache_capacity" = 32768;
        "network.http.pacing.requests.enabled" = false;
        "network.dnsCacheEntries" = 1200;
        "network.dnsCacheExpiration" = 3600;
        "network.dns.max_high_priority_threads" = 8;

        /****************************************************************************
                                                                                                                                                                                                                                				 * SECTION: SECUREFOX                                                       *
                                                                                                                                                                                    				****************************************************************************/
        /** TRACKING PROTECTION ***/
        "browser.contentblocking.category" = "strict";
        "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com, *.facebook.com, *.youtube.com, *.netflix, *.binge.com";
        "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.twimg.com, *.facebook.com";
        "privacy.query_stripping.strip_list" = "__hsfp __hssc __hstc __s _hsenc _openstat dclid fbclid gbraid gclid hsCtaTracking igshid mc_eid ml_subscriber ml_subscriber_hash msclkid oft_c oft_ck oft_d oft_id oft_ids oft_k oft_lk oft_sk oly_anon_id oly_enc_id rb_clickid s_cid twclid vero_conv vero_id wbraid wickedid yclid";
        "browser.uitour.enabled" = false;
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.globalprivacycontrol.functionality.enabled" = true;

        /** OCSP & CERTS / HPKP ***/
        "security.OCSP.enabled" = 0;
        "security.remote_settings.crlite_filters.enabled" = true;
        "security.pki.crlite_mode" = 2;
        "security.cert_pinning.enforcement_level" = 2;

        /** SSL / TLS ***/
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;
        "browser.xul.error_pages.expert_bad_cert" = true;
        "security.tls.enable_0rtt_data" = false;

        /** DISK AVOIDANCE ***/
        "browser.cache.disk.enable" = false;
        "browser.privatebrowsing.forceMediaMemoryCache" = true;
        "browser.sessionstore.privacy_level" = 2;

        /** SHUTDOWN & SANITIZING ***/
        "privacy.history.custom" = true;

        /** SPECULATIVE CONNECTIONS ***/
        "network.http.speculative-parallel-limit" = 0;
        "network.dns.disablePrefetch" = true;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.places.speculativeConnect.enabled" = false;
        "network.prefetch-next" = false;
        "network.predictor.enabled" = false;
        "network.predictor.enable-prefetch" = false;

        /** SEARCH / URL BAR ***/
        "browser.search.separatePrivateDefault.ui.enabled" = true;
        "browser.urlbar.update2.engineAliasRefresh" = true;
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "security.insecure_connection_text.enabled" = true;
        "security.insecure_connection_text.pbmode.enabled" = true;
        "network.IDN_show_punycode" = true;

        /** HTTPS-FIRST MODE ***/
        "dom.security.https_first" = true;

        /** PROXY / SOCKS / IPv6 ***/
        "network.proxy.socks_remote_dns" = true;
        "network.file.disable_unc_paths" = true;
        "network.gio.supported-protocols" = "";

        /** ADDRESS + CREDIT CARD MANAGER ***/
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "extensions.formautofill.heuristics.enabled" = false;
        "browser.formfill.enable" = false;

        /** MIXED CONTENT + CROSS-SITE ***/
        "network.auth.subresource-http-auth-allow" = 1;
        "pdfjs.enableScripting" = false;
        "extensions.postDownloadThirdPartyPrompt" = false;
        "permissions.delegation.enabled" = false;

        /** HEADERS / REFERERS ***/
        "network.http.referer.XOriginTrimmingPolicy" = 2;

        /** CONTAINERS ***/
        "privacy.userContext.ui.enabled" = true;

        /** WEBRTC ***/
        "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
        "media.peerconnection.ice.default_address_only" = true;

        /** SAFE BROWSING ***/
        "browser.safebrowsing.downloads.remote.enabled" = false;

        /** MOZILLA ***/
        "accessibility.force_disabled" = 1;
        #"identity.fxaccounts.enabled" = false;
        "browser.tabs.firefox-view" = false;
        "permissions.default.desktop-notification" = 2;
        "permissions.default.geo" = 2;
        "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
        "geo.provider.use_gpsd" = false; # LINUX
        "geo.provider.use_geoclue" = false; # LINUX
        "permissions.manager.defaultsUrl" = "";
        "webchannel.allowObject.urlWhitelist" = "";

        /** TELEMETRY ***/
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.opt-out" = true;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "browser.discovery.enabled" = false;
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
        "captivedetect.canonicalURL" = "";
        "network.captive-portal-service.enabled" = false;
        "network.connectivity-service.enabled" = false;
        "default-browser-agent.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";
        "browser.ping-centre.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;

        /****************************************************************************
                                                                                                                                                                                                                                				 * SECTION: PESKYFOX                                                        *
                                                                                                                                                                                    				****************************************************************************/
        /** MOZILLA UI ***/
        "layout.css.prefers-color-scheme.content-override" = 0;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "app.update.suppressPrompts" = true;
        "browser.compactmode.show" = true;
        "browser.privatebrowsing.vpnpromourl" = "";
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.preferences.moreFromMozilla" = false;
        "browser.tabs.tabmanager.enabled" = false;
        "browser.aboutwelcome.enabled" = false;
        "findbar.highlightAll" = true;
        "middlemouse.contentLoadURL" = false;
        "browser.privatebrowsing.enable-new-indicator" = false;

        /** FULLSCREEN ***/
        "full-screen-api.transition-duration.enter" = "0 0";
        "full-screen-api.transition-duration.leave" = "0 0";
        "full-screen-api.warning.delay" = -1;
        "full-screen-api.warning.timeout" = 0;

        /** URL BAR ***/
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.suggest.calculator" = true;
        "browser.urlbar.unitConversion.enabled" = true;

        /** NEW TAB PAGE ***/
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

        /*** POCKET ***/
        "extensions.pocket.enabled" = false;

        /** DOWNLOADS ***/
        "browser.download.useDownloadDir" = false;
        "browser.download.alwaysOpenPanel" = false;
        "browser.download.manager.addToRecentDocs" = false;
        "browser.download.always_ask_before_handling_new_types" = true;

        /** PDF ***/
        "browser.download.open_pdf_attachments_inline" = true;

        /** TAB BEHAVIOR ***/
        "browser.tabs.loadBookmarksInTabs" = true;
        "browser.bookmarks.openInTabClosesMenu" = false;
        "layout.css.has-selector.enabled" = true;
        "cookiebanners.service.mode" = 2;
        "cookiebanners.service.mode.privateBrowsing" = 2;

        /****************************************************************************
                                                                                                                                                                                                                                				 * SECTION: SMOOTHFOX                                                       *
                                                                                                                                                                                    				****************************************************************************/
        # visit https://github.com/yokoffing/Betterfox/blob/master/Smoothfox.js
        # Enter your scrolling prefs below this line:
        "apz.overscroll.enabled" = true;
        "general.smoothScroll" = true;
        "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
        "general.smoothScroll.msdPhysics.enabled" = true;
        "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 600;
        "general.smoothScroll.msdPhysics.regularSpringConstant" = 650;
        "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 25;
        "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = 2.0;
        "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 250;
        "general.smoothScroll.currentVelocityWeighting" = 1.0;
        "general.smoothScroll.stopDecelerationWeighting" = 1.0;
        "mousewheel.default.delta_multiplier_y" = 300;
      };


      userChrome = /* css */''

        :root {
          --uc-border-radius: 0px;
          --uc-status-panel-spacing: 6px;
        }
        /* remove window control buttons */
        .titlebar-buttonbox-container { display: none !important; }


        #pageActionButton { display: none !important; }

        #PanelUI-menu-button { padding: 0px !important; }
        #PanelUI-menu-button .toolbarbutton-icon { width: 1px !important; }
        #PanelUI-menu-button .toolbarbutton-badge-stack { padding: 0px !important; }





        :root {
          --uc-toolbar-position: 4;
        }
        @media { :root {
          --uc-darken-toolbar: 0;
        }}

        /* Disable the Navigation Buttons */
        #back-button,
        #forward-button { display: none !important; }
        /* Disables the Tracking Protection Shield */
        #tracking-protection-icon-container { display: none !important; }
        #identity-permission-box { display: none !important; }
        #identity-box { display: none !important }

        /* Hide everything BUT the zoom indicator within the URL Bar */
        #page-action-buttons > :not(#urlbar-zoom-button) { display: none !important; }

        /* Hide the »Go«-arrow in the URL Bar */
        #urlbar-go-button { display: none !important; }


        /* Hide the secondary Tab Label
        * e.g. playing indicator (the text, not the icon) */
        .tab-secondary-label { display: none !important; }

        /*---+---+---+---+---+---+---+
        | C | O | L | O | U | R | S |
        +---+---+---+---+---+---+---*/


        @media { :root {
        /* These colours are (mainly) used by the Container Tabs Plugin */
          --uc-identity-colour-blue: #${config.colorScheme.palette.base0D};
          --uc-identity-colour-turquoise: #${config.colorScheme.palette.base0C};
          --uc-identity-colour-green: #${config.colorScheme.palette.base0B};
          --uc-identity-colour-yellow: #${config.colorScheme.palette.base0A};
          --uc-identity-colour-orange: #${config.colorScheme.palette.base06};
          --uc-identity-colour-red: #${config.colorScheme.palette.base08};
          --uc-identity-colour-pink: #${config.colorScheme.palette.base0F};
          --uc-identity-colour-purple: #${config.colorScheme.palette.base0E};
        /*  Cascades main Colour Scheme */
          --uc-base-colour: #${config.colorScheme.palette.base00};
          --uc-highlight-colour: #${config.colorScheme.palette.base03};
          --uc-inverted-colour: #${config.colorScheme.palette.base05};
          --uc-muted-colour: #${config.colorScheme.palette.base04};
          --uc-accent-colour: var(--uc-identity-colour-blue);
        }
      }
      /* reassigning variables based on the colours set above. */

      :root {
        --lwt-frame: var(--uc-base-colour) !important;
        --lwt-accent-color: var(--lwt-frame) !important;
        --lwt-text-color: var(--uc-inverted-colour) !important;
        --toolbar-field-color: var(--uc-inverted-colour) !important;
        --toolbar-field-focus-color: var(--uc-inverted-colour) !important;
        --toolbar-field-focus-background-color: var(--uc-highlight-colour) !important;
        --toolbar-field-focus-border-color: transparent !important;
        --toolbar-field-background-color: var(--lwt-frame) !important;
  --lwt-toolbar-field-highlight: var(--uc-inverted-colour) !important;
  --lwt-toolbar-field-highlight-text: var(--uc-highlight-colour) !important;
  --urlbar-popup-url-color: var(--uc-accent-colour) !important;

  --lwt-tab-text: var(--lwt-text-colour) !important;

  --lwt-selected-tab-background-color: var(--uc-highlight-colour) !important;

  --toolbar-bgcolor: var(--lwt-frame) !important;
  --toolbar-color: var(--lwt-text-color) !important;
  --toolbarseparator-color: var(--uc-accent-colour) !important;
  --toolbarbutton-hover-background: var(--uc-highlight-colour) !important;
  --toolbarbutton-active-background: var(--toolbarbutton-hover-background) !important;

  --lwt-sidebar-background-color: var(--lwt-frame) !important;
  --sidebar-background-color: var(--lwt-sidebar-background-color) !important;

  --urlbar-box-bgcolor: var(--uc-highlight-colour) !important;
  --urlbar-box-text-color: var(--uc-muted-colour) !important;
  --urlbar-box-hover-bgcolor: var(--uc-highlight-colour) !important;
  --urlbar-box-hover-text-color: var(--uc-inverted-colour) !important;
  --urlbar-box-focus-bgcolor: var(--uc-highlight-colour) !important;

}



.identity-color-blue      { --identity-tab-color: var(--uc-identity-colour-blue)      !important; --identity-icon-color: var(--uc-identity-colour-blue)      !important;  }
.identity-color-turquoise { --identity-tab-color: var(--uc-identity-colour-turquoise) !important; --identity-icon-color: var(--uc-identity-colour-turquoise) !important; }
.identity-color-green     { --identity-tab-color: var(--uc-identity-colour-green)     !important; --identity-icon-color: var(--uc-identity-colour-green)     !important; }
.identity-color-yellow    { --identity-tab-color: var(--uc-identity-colour-yellow)    !important; --identity-icon-color: var(--uc-identity-colour-yellow)    !important; }
.identity-color-orange    { --identity-tab-color: var(--uc-identity-colour-orange)    !important; --identity-icon-color: var(--uc-identity-colour-orange)    !important; }
.identity-color-red       { --identity-tab-color: var(--uc-identity-colour-red)       !important; --identity-icon-color: var(--uc-identity-colour-red)       !important; }
.identity-color-pink      { --identity-tab-color: var(--uc-identity-colour-pink)      !important; --identity-icon-color: var(--uc-identity-colour-pink)      !important; }
.identity-color-purple    { --identity-tab-color: var(--uc-identity-colour-purple)    !important; --identity-icon-color: var(--uc-identity-colour-purple)    !important; }

:root {
  --toolbarbutton-border-radius: var(--uc-border-radius) !important;
  --tab-border-radius: var(--uc-border-radius) !important;
  --arrowpanel-border-radius: var(--uc-border-radius) !important;
}


#main-window,
#toolbar-menubar,
#TabsToolbar,
#navigator-toolbox,
#sidebar-box,
#nav-bar { box-shadow: none !important; }


#main-window,
#toolbar-menubar,
#TabsToolbar,
#PersonalToolbar,
#navigator-toolbox,
#sidebar-box,
#nav-bar { border: none !important; }


/* remove "padding" left and right from tabs */
.titlebar-spacer { display: none !important; }

#PersonalToolbar {
  padding: 0px !important;
  box-shadow: inset 0 0 50vh rgba(0, 0, 0, var(--uc-darken-toolbar)) !important;;
}

#statuspanel #statuspanel-label {

  border: none !important;
  border-radius: var(--uc-border-radius) !important;

}
  @media (min-width: 749px) {
  #navigator-toolbox { display: flex; flex-wrap: wrap; flex-direction: row; }
  #nav-bar {
    order: var();
    width: var(35vw);
  }

  #nav-bar #urlbar-container { min-width: 10vw !important; width: auto !important; }


  #titlebar {
    order: 2;
    width: calc(100vw - 35vw - 1px);
  }


  #PersonalToolbar {
    order: 1;
    width: 100%;
  }


  #navigator-toolbox:focus-within #nav-bar { width: var(35vw); }
  #navigator-toolbox:focus-within #titlebar { width: calc(100vw - 35vw - 1px); }
  #statuspanel #statuspanel-label { margin: 0 0 var(--uc-status-panel-spacing) var(--uc-status-panel-spacing) !important; }
  #navigator-toolbox:not(:-moz-lwtheme) { background: var(--toolbar-field-background-color) !important; }



#nav-bar {
  padding-block-start: 0px !important;
  border:     none !important;
  box-shadow: none !important;
  background: transparent !important;
}


#urlbar,
#urlbar * {
  padding-block-start: 0px !important;
  outline: none !important;
  box-shadow: none !important;
}


#urlbar-background { border: transparent !important; }

#urlbar[focused='true']
  > #urlbar-background,
#urlbar:not([open])
  > #urlbar-background { background: var(--toolbar-field-background-color) !important; }


#urlbar[open]
  > #urlbar-background { background: var(--toolbar-field-background-color) !important; }


.urlbarView-row:hover
  > .urlbarView-row-inner,
.urlbarView-row[selected]
  > .urlbarView-row-inner { background: var(--toolbar-field-focus-background-color) !important; }


.urlbar-icon, #urlbar-go-button { margin: auto; }
.urlbar-page-action { padding: 0 inherit !important; }
.urlbar-page-action .urlbar-icon { margin-top: 6px !important; }
}

/* remove gap after pinned tabs */
#tabbrowser-tabs[haspinnedtabs]:not([positionpinnedtabs])
  > #tabbrowser-arrowscrollbox
  > .tabbrowser-tab:nth-child(1 of :not([pinned], [hidden])) { margin-inline-start: 0 !important; }

  .tab-text.tab-label{
    font-size: 13px;
  }

/* Hides the list-all-tabs button*/
#alltabs-button { display: none !important; }

/* remove tab shadow */
.tabbrowser-tab
  >.tab-stack
  > .tab-background { box-shadow: none !important;  }

/* multi tab selection */
#tabbrowser-tabs:not([noshadowfortests]) .tabbrowser-tab:is([multiselected])
  > .tab-stack
  > .tab-background:-moz-lwtheme { outline-color: var(--toolbarseparator-color) !important; }


/* container tabs indicator */
.tabbrowser-tab[usercontextid]
  > .tab-stack
  > .tab-background
  > .tab-context-line {

    margin: -1px var(--container-tabs-indicator-margin) 0 var(--container-tabs-indicator-margin) !important;
    height: 1px !important;

    box-shadow: var(--uc-identity-glow) var(--identity-tab-color) !important;

}


/* show favicon when media is playing but tab is hovered */
.tab-icon-image:not([pinned]) { opacity: 1 !important; }




/* style and position speaker icon */
.tab-icon-overlay:not([sharing], [crashed]):is([soundplaying], [muted], [activemedia-blocked]) {

  stroke: transparent !important;
  background: transparent !important;
  opacity: 1 !important; fill-opacity: 0.8 !important;

  color: currentColor !important;

  stroke: var(--toolbar-bgcolor) !important;
  background-color: var(--toolbar-bgcolor) !important;

}

/* change the colours of the speaker icon on active tab to match tab colours */
.tabbrowser-tab[selected] .tab-icon-overlay:not([sharing], [crashed]):is([soundplaying], [muted], [activemedia-blocked]) {
  stroke: var(--toolbar-bgcolor) !important;
  background-color: var(--toolbar-bgcolor) !important;

}


.tab-icon-overlay:not([pinned], [sharing], [crashed]):is([soundplaying], [muted], [activemedia-blocked]) { margin-inline-end: 9.5px !important; }


.tabbrowser-tab:not([image]) .tab-icon-overlay:not([pinned], [sharing], [crashed]) {

  top: 0 !important;
  padding: 0 !important;
  margin-inline-end: 5.5px !important;
  inset-inline-end: 0 !important;

}


.tab-icon-overlay:not([crashed])[soundplaying]:hover,
.tab-icon-overlay:not([crashed])[muted]:hover,
.tab-icon-overlay:not([crashed])[activemedia-blocked]:hover {

  color: currentColor !important;
  stroke: var(--toolbar-color) !important;
  background-color: var(--toolbar-color) !important;
  fill-opacity: 0.95 !important;

}


.tabbrowser-tab[selected] .tab-icon-overlay:not([crashed])[soundplaying]:hover,
.tabbrowser-tab[selected] .tab-icon-overlay:not([crashed])[muted]:hover,
.tabbrowser-tab[selected] .tab-icon-overlay:not([crashed])[activemedia-blocked]:hover {

  color: currentColor !important;
  stroke: var(--toolbar-color) !important;
  background-color: var(--toolbar-color) !important;
  fill-opacity: 0.95 !important;

}

/* speaker icon colour fix on hover */
#TabsToolbar .tab-icon-overlay:not([crashed])[soundplaying]:hover,
#TabsToolbar .tab-icon-overlay:not([crashed])[muted]:hover,
#TabsToolbar .tab-icon-overlay:not([crashed])[activemedia-blocked]:hover { color: var(--toolbar-bgcolor) !important; }

/* selected tab colour fix*/
.tabbrowser-tab[selected] .tab-content {
  background-color: var(--uc-highlight-colour) !important;
}
      '';

      userContent = /*css*/ ''


      '';
    };
  };
}
