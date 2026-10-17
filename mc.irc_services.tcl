##
# IRC Services v1.1
#  by MC_8 - Carl M. Gregory <mc8@purehype.net>
#  This script will only run on eggdrop 1.5.5 or greater.
#
#    R.I.P. Mom, To always be remembered; Nancy Marie Gregory.
#
# My Website - http://mc.purehype.net:81/
# Have a bug?  http://mc.purehype.net:81/bugzilla/
##

##
# This will allow your bot to interface with an IRC servers' channel services.
# This should work fine with QuakeNet/ Dalnet/ Undernet and probably others.
# Many ask, can this be used for Undernet's new +x, yes.. it can.
#
# You register with Undernet via;
#   http://cservice.undernet.org/live/
#
# For best results for Undernet usage,
#   1) Ensure your bot has an access level of 399 or greater.  Such a high
#      access only needed for the `join_service` variable you will read about
#      below, assuming your using the default command already in place.  You
#      don't need to give the bot that high of access if you intend to never use
#      that variable's default command.
##

##
# Commands (dcc)
##
# chanset <channel> <+/->mc.irc_services
#   This will enable or disable this script for the specified channel.  This is
#   only for the `need:*` variables.  The script still logs in as it should
#   regardless of what you set any channel to.
#
# status
#   This will show the normal status for core eggdrop, but also appends the
#   status of the script.
##

##
# Configuration
##
#

# What's the username the bot is to use to log into the irc network services
# bot?
set mc_us(login) "username"

# What's the password the bot is to use to log into the irc network services
# bot?
set mc_us(password) "password"

# [0=no/1=yes] Do you want the bot to wait until logged in before joining it's
# channels?
set mc_us(wait_for_login) 1

# How long, in seconds, do you want to wait for the service to state your logged
# in before timing out and having the bots join the channels regardless?  This
# setting is only valid if `wait_for_login` is set to 1.  Setting this to 0 will
# represent a never ending timeout.
set mc_us(wait_for_login:timeout) 60

# What IRC Nickname do you want before you log in?  After you log in, your
# normal nick will be set back.  Set this to "" to disable this function.
set mc_us(wait_for_login:nick) "wait?????"

# After logged in, the script will try to find a usable nickname in the order of
# $nick $altnick then $altnick 0-9.  Should it not be able to find a usable
# nickname, how long (in seconds) should it wait before trying to find a usable
# nickname again?  You can set this to 0 to have it not try again, in such a
# case it will just join even though it's nick is still set to
# `wait_for_login:nick`.
set mc_us(wait_for_login:wait_nick) 60

# What's the maximum nickname length supported by the irc server the bot is
# connecting to?
#   Undernet uses: 9
set mc_us(max_nick_length) 9

# What raw numeric verifies that the bot is logged in?  This raw numeric must
# be returned during the WHOIS reply, before end of whois.  Set this to "" if
# the irc server your on does not support numeric raw replies to show your
# logged in -- of course, the bot will never know if it's logged in or not (may
# want to encourage the irc network to get with the program).
#   Dalnet uses:    307
#   Quakenet uses:  330
#   Undernet uses:  330
set mc_us(verify_login) 330

# What's the irc nickname of the service that will NOTICE you back that you have
# logged in?
#   Undernet uses: X
#   Dalnet uses:   NickServ
set mc_us(service_nick) "X"

# What's the irc nickname of the service that will take part in channel
# services?  Unlike service_nick, this is the actual bot that you send requests
# to for ops and such.  For Undernet, it's just 1 bot for both, X.  But dalnet
# uses 2 different bots for this, see the example below.
#   Undernet uses: X
#   Dalnet uses:   ChanServ
set mc_us(service_chan) "X"

# Does the channel service ever join the channel?
#  0 = no, 1 = yes
#   Undernet uses: 1
#   Dalnet uses:   0
set mc_us(service_chan_join) 1

# How do you log into the service bot?
# -- If your using this script for Undernet's X service, you don't need to
#    configure this.  It's already setup to work with X fine as of 10.29.2002.
#   This supports multi commands, 1 command per line.
#   Valid commands are:
#     /raw <code>               - Sends the raw code to the irc server.
#     /msg <nick> <message>     - Sends <nick> a <message> private message.
#     /notice <nick> <message>  - sends <nick> a <message> via notice.
#   Valid replacement variables are:
#     %username   - The username, set above.
#     %password   - The password, set above.
#     %botnick    - The bot's irc nick.
#     %uhost      - The bots ident@host.
set mc_us(how_to_login) {
  /msg x@channels.undernet.org login %username %password
}

# After you log in, what command do you want to preform?
# -- If your using this script for Undernet's X service, you don't need to
#    configure this.  It's already setup to work with X fine as of 10.29.2002.
#   This supports multi commands, 1 command per line.
#   Valid commands are:
#     /raw <code>               - Sends the raw code to the irc server.
#     /msg <nick> <message>     - Sends <nick> a <message> private message.
#     /notice <nick> <message>  - sends <nick> a <message> via notice.
#   Valid replacement variables are:
#     %username   - The username, set above.
#     %password   - The password, set above.
#     %botnick    - The bot's irc nick.
#     %uhost      - The bots ident@host.
set mc_us(do_after_login) {
  /raw MODE %botnick +x
  /msg X set invisible on
}

# What do you want the bot to do up needing op/ unban/ invite/ limit/ key?
# -- If your using this script for Undernet's X service, you don't need to
#    configure these.  There already setup to work with X fine as of 10.29.2002.
#   This supports multi commands, 1 command per line.
#   Valid commands are:
#     /raw <code>               - Sends the raw code to the irc server.
#     /msg <nick> <message>     - Sends <nick> a <message> private message.
#     /notice <nick> <message>  - sends <nick> a <message> via notice.
#   Valid replacement variables are:
#     %username   - The username, set above.
#     %password   - The password, set above.
#     %botnick    - The bot's irc nick.
#     %uhost      - The bots ident@host.
#     %channel    - The channel the need action is triggered.
set mc_us(need:op) {
  /msg X unban %channel %botnick
  /msg X op %channel %botnick
}
set mc_us(need:unban) {
  /msg X unban %channel %botnick
  /msg X invite %channel
}
set mc_us(need:invite) {
  /msg X invite %channel
}
set mc_us(need:limit) {
  /msg X invite %channel
}
set mc_us(need:key) {
  /msg X invite %channel
}

# Suppose the bot isn't in the channel, and he need's to be joined.  What do you
# do to make him join?
#   Valid commands are:
#     /raw <code>               - Sends the raw code to the irc server.
#     /msg <nick> <message>     - Sends <nick> a <message> private message.
#     /notice <nick> <message>  - sends <nick> a <message> via notice.
#   Valid replacement variables are:
#     %username   - The username, set above.
#     %password   - The password, set above.
#     %botnick    - The bot's irc nick.
#     %uhost      - The bots ident@host.
#     %channel    - The channel the need action is triggered.
set mc_us(join_service) {
  /msg X join %channel
}

# To avoid eggdrop putting the services bot on ignore, please specify it's
# nick!ident@host so that I may have eggdrop just exempt the bot for flood
# triggers.  Channel services may trigger floods due to the large amounts of
# notices it replies with.
set mc_us(ignore_service_flood) "x!cservice@undernet.org"


## SVS Client (Script Version Service) v3.2.1 ##
# Once a day, the SVS Client will connect to MC_8's SVS Server to determine if
# there is a newer version of this script available.  This will only notify
# users of the new version via a note.  It's up to the owner of the bot to
# download, adjust settings then install the script.

# If a newer version is found, whom do you want to notify?  The notification is
# sent via a note.  Separate each user with a space, or set this to "" to
# disable SVS notification.  For those whom know TCL; do not put this in list
# format, keep it in string format.
set mc_us(svs:notify) "MC_8"

# Would you like to restrict the concept of a new version to stable releases
# only?
#   0 = No, inform of both stable and beta release versions.
#   1 = Yes, inform of only stable release versions.
set mc_us(svs:mode) 0


#
##

##
# Done with configurations, do not edit past here unless you know TCL.
##
#

#Script:mc_us

set mc_us(script)      "IRC Services"
set mc_us(version)     "v1.1"
set mc_us(svs:script)  "irc_services"
set mc_us(svs:version) "001001000000"
set mc_us(svs:server)  "mc.svs.purehype.net"
set mc_us(svs:port)    "81"
set mc_us(svs:get)     "/index.tcl"
set mc_us(svs:query)   \
  "svs=$mc_us(svs:script)&version=$mc_us(svs:version)"

catch {unset temp}
if {![info exists numversion] || ($numversion < "1050500")} {
  set temp(tag) "$mc_us(script) $mc_us(version)"
  putlog "$temp(tag) by MC_8 will only work on eggdrop 1.5.5 or greater."
  putlog "$temp(tag)  will not work with eggdrop $version."
  putlog "$temp(tag)  not loaded."
  return 1
}

foreach temp(module) [list channels server irc] {
  set temp(loaded) 0
  foreach temp(loaded_module) [modules] {
    if {[lindex $temp(loaded_module) 0] == $temp(module)} {
      set temp(loaded) 1
      break
    }
  }
  if {!$temp(loaded)} {
    if {[catch {loadmodule $temp(module)} output]} {
      set temp() "$mc_us(script) $mc_us(version)"
      putlog \
        "$temp() by MC_8 cannot load $temp(module) module, script load halted."
      putlog "$temp()  loadmodule error; $output"
      return 1
    }
  }
}


# Error system, v3.0
proc mc:us:error {command error arg} {
  global mc_us version lastbind errorInfo
  putlog "Error in script $mc_us(script) $mc_us(version)."
  putlog "    Error System: v3.0"
  putlog "       Last Bind: [expr {[info exists lastbind]?$lastbind:"-NULL-"}]"
  putlog "         Command: $command"
  putlog "       Arguments: $arg"
  putlog "       Error Msg: $error"
  putlog "    Egg. Version: [expr {[info exists version]?$version:"-NULL-"}]"
  putlog "     TCL Version: [info tclversion]"
  putlog "  TCL Patchlevel: [info patchlevel]"
  putlog "*** Please submit this bug so MC_8 can fix it.  Visit"
  putlog "*** http://mc.purehype.net:81/bugzilla/ to properly report the bug."
  putlog \
    "*** Please include ALL info. in the bug report, including the next(s)."
  error $errorInfo
}

proc mc:us:errchk {command arg} {
  if {![catch {eval $command $arg} return]} {return $return}
  mc:us:error $command $return $arg
  return 0
}
# ^

setudef flag mc.irc_services

if {![info exists mc_us(:cache:ignore_303)]} {
  set mc_us(:cache:ignore_303) 0
}

foreach temp(bind) [binds mc:us:filt:status] {
  unbind [lindex $temp(bind) 0] [lindex $temp(bind) 1] [lindex $temp(bind) 2] \
    [lindex $temp(bind) 4]
}
set temp(bind) [lindex [binds *dcc:status] 0]
if {$temp(bind) == ""} {
  bind filt m|m .status mc:us:filt:status
  proc *dcc:status {{args ""}} {}
} else {
  bind filt [lindex $temp(bind) 1] .[lindex $temp(bind) 2] mc:us:filt:status
}
proc mc:us:filt:status {index text} {
  return [mc:us:errchk mc:us:filt:status_ [list $index $text]]
}
proc mc:us:filt:status_ {index text} {
  global mc_us
  *dcc:status [idx2hand $index] $index $text

  putdcc $index "$mc_us(script) $mc_us(version), status"
  putdcc $index [format {    %-14s: %s}  Username $mc_us(login)]
  putdcc $index [format {    %-14s: %s}  Password ******]
  set temp(1) [expr {$mc_us(wait_for_login)?"yes":"no"}]
  if {$temp(1) == "yes"} {
    if {!$mc_us(wait_for_login:timeout)} {
      append temp(1) " (timeout: never)"
    } else {
      append temp(1) " (timeout: [duration $mc_us(wait_for_login:timeout)])"
    }
    putdcc $index [format {    %-14s: %s}  "Wait for login" $temp(1)]
  }
  set temp(is_logged_in) [expr {[mc:us:list is_logged_in]?"yes":"no"}]
  putdcc $index [format {    %-14s: %s} "Logged in now" $temp(is_logged_in)]
  if {$temp(is_logged_in) == "no"} {
    set temp() [info exists mc_us(:cache:last_message)]
    set temp() [expr {$temp()?$mc_us(:cache:last_message):""}]
    putdcc $index [format {      %+19s: %s} "Last message from service" $temp()]
  }
}

bind evnt - init-server mc:us:evnt
bind evnt - connect-server mc:us:evnt
bind evnt - disconnect-server mc:us:evnt
proc mc:us:evnt {type} {
  return [mc:us:errchk mc:us:evnt_ [list $type]]
}
proc mc:us:evnt_ {type} {
  global mc_us server botnick botnet-nick
  switch -- $type {
    "connect-server" {
      global nick altnick

      if {$mc_us(wait_for_login:nick) != ""} {
        if {$mc_us(wait_for_login:nick) != $nick} {
          if {![info exists mc_us(:cache:nick)] ||
              ($mc_us(:cache:nick) != "")} {
            set mc_us(:cache:nick) $nick
          }
          set nik $mc_us(wait_for_login:nick)
          while {[regexp -- {\?} $nik]} {regsub -- {\?} $nik [rand 10] nik}
          set nick $nik
        }
        if {$mc_us(wait_for_login:nick) != $altnick} {
          if {![info exists mc_us(:cache:altnick)] ||
              ($mc_us(:cache:altnick) != "")} {
            set mc_us(:cache:altnick) $altnick
          }
          set altnick $mc_us(wait_for_login:nick)
        }
      }
      catch {unset mc_us(:cache:ison_test)}
      catch {unset mc_us(:cache:has_nick)}
      set mc_us(:cache:ignore_303) 1
    }

    "init-server" {
      if {$server == ""} {
        # Possible fluke?
        return 0
      }

      mc:us:list wait 1
      mc:us:list is_logged_in 0
      mc:us:list login

      return 1
    }

    "disconnect-server" {
      mc:us:list wait 0
      mc:us:list is_logged_in 0
    }

  }
}

bind notc - * mc:us:notc
proc mc:us:notc {nick uhost handle text {dest ""}} {
  return [mc:us:errchk mc:us:notc_ [list $nick $uhost $handle $text $dest]]
}
proc mc:us:notc {nick uhost handle text dest} {
  global mc_us
  if {[string tolower $nick] != [string tolower $mc_us(service_nick)]} {
    return 0
  }
  global mc_us
  if {[info exists mc_us(:cache:notice)]} {return 1}
  utimer 2 [list catch {unset mc_us(:cache:notice)}]
  set mc_us(:cache:last_message) $text
  mc:us:list verify
  return 2
}

# Gotta kill the binds and redo them, since were specifying `verify_login`
# within the raw bind it's self.
foreach temp(bind) [binds mc:us:raw] {
  unbind  [lindex $temp(bind) 0] [lindex $temp(bind) 1] [lindex $temp(bind) 2] \
    [lindex $temp(bind) 4]
}

bind raw - $mc_us(verify_login) mc:us:raw
bind raw - 221 mc:us:raw
bind raw - 303 mc:us:raw
bind raw - 318 mc:us:raw
proc mc:us:raw {from keyword text} {
  return [mc:us:errchk mc:us:raw_ [list $from $keyword $text]]
}
proc mc:us:raw {from keyword text} {
  global mc_us
  set text [split $text]
  if {![isbotnick [lindex $text 1]] && ($keyword != "221") &&
      ($keyword != "303")} {return 0}
  if {$keyword == $mc_us(verify_login)} {set keyword "verify"}
  switch -- $keyword {
    221 {
      # botname +ix
      set mc_us(:cache:umode) [lindex $text 1]
    }
    303 {
      # Ison reply.
      # botname :<current_nick> [nick1 [nick2 [nickN]]]

      if {![info exists mc_us(:cache:ison_test)] ||
           [info exists mc_us(:cache:has_nick)]} {return 0}
      if {$mc_us(:cache:ignore_303)} {return 1}
      set origional [lindex $text 1]
      regexp -- {^:?(.*)$} $origional -> origional
      global botnick
      if {![isbotnick $origional]} {return 0}
      set list [string tolower [lrange $text 2 end]]
      set usable ""
      foreach test_nick [lrange $mc_us(:cache:ison_test) 1 end] {
        set ltest_nick [string tolower $test_nick]
        if {[lsearch -exact $list $ltest_nick] == "-1"} {
          set usable $test_nick
          break
        }
      }

      set temp(join_chan) "proceeding with join of channels"
      if {$usable == ""} {
        if {$mc_us(wait_for_login:wait_nick)} {
          set temp() "trying again in $mc_us(wait_for_login:wait_nick) seconds"
          putloglev o * "$mc_us(script): Usable nick not found, $temp()."
          utimer $mc_us(wait_for_login:wait_nick) \
            [list mc:us:list get_nick again]
          set mc_us(:cache:ignore_303) 1
          return 1
        }
        putloglev o * "$mc_us(script): Usable nick not found, $temp(join_chan)."
      } else {
        if {[string tolower $usable] != [string tolower $mc_us(:cache:nick)] &&
         [string tolower $usable] != [string tolower $mc_us(:cache:altnick)]}  {
          putserv "NICK $usable"
        }
        putloglev o * "$mc_us(script): Usable nick found, $temp(join_chan)."
      }

      global nick altnick
      if {[info exists mc_us(:cache:nick)] && $mc_us(:cache:nick) != ""} {
        set nick $mc_us(:cache:nick)
      }
      if {[info exists mc_us(:cache:altnick)] && $mc_us(:cache:altnick) != ""} {
        set altnick $mc_us(:cache:altnick)
      }

      unset mc_us(:cache:ison_test)
      set mc_us(:cache:has_nick) 1
      set mc_us(:cache:ignore_303) 0

      mc:us:list join_channels
      return 1
    }
    318 {
      # botname botname :End of /WHOIS list.
      mc:us:list verify [expr {[info exists mc_us(:cache:whois)]?
        $mc_us(:cache:whois):"0"}]
      set mc_us(:cache:whois) 0
    }
    verify {
      # botname botname username :is logged in as
      set mc_us(:cache:whois) 1
    }
  }
  return 0
}

bind need - * mc:us:need
proc mc:us:need {channel type} {
  return [mc:us:errchk mc:us:need_ [list $channel $type]]
}
proc mc:us:need_ {channel type} {
  global mc_us botnick
  if {![mc:us:chanflag $channel mc.irc_services]} {return 0}

  set temp() [expr {($type == "limit")?"limit change":$type}]

  if {![mc:us:list is_logged_in]} {
    putlog "$mc_us(script): Need $temp() in $channel, but not logged in."
    return 0
  }

  if {[botonchan $channel]} {
    if {$mc_us(service_chan_join) &&
        ![onchan $mc_us(service_chan) $channel]} {
      set temp(2) "Need $temp() in $channel; $mc_us(service_chan) is not on "
      append temp(2) "channel, "
      if {[string trim $mc_us(join_service) " \t\r\n"] != ""} {
        append temp(2) "sending $mc_us(service_chan) a join request, "
        mc:us:list process_message [list $channel $mc_us(join_service)]
      }
      append temp(2) "waiting 10 seconds."
      putlog "$mc_us(script): $temp(2)"

      set temp(cmd) [list mc:us:need $channel $type]
      foreach utimer [utimers] {
        if {[learch -exact $utimer $temp(cmd)] == 1} {
          killutimer $utimer [lindex $utimer 2]
        }
      }
      utimer 10 $temp(cmd)

      return 0
    } elseif {$mc_us(service_chan_join) &&
              ![isop $mc_us(service_chan) $channel]} {
      set temp(2) "$mc_us(service_chan) is not opped on $channel, "
      append temp(2) "waiting 10 seconds."
      putlog "$mc_us(script): $temp(2)"

      set temp(cmd) [list mc:us:need $channel $type]
      foreach utimer [utimers] {
        if {[learch -exact $utimer $temp(cmd)] == 1} {
          killutimer $utimer [lindex $utimer 2]
        }
      }
      utimer 10 $temp(cmd)

      return 0
    }
  }

  set temp(2) "Need $temp() in $channel, "
  append temp(2) "sending request to $mc_us(service_chan)."
  putlog "$mc_us(script): $temp(2)"

  mc:us:list process_message [list $channel $mc_us(need:$type)]

  return 1
}

bind flud - msg mc:us:flud:msg
proc mc:us:flud:msg {nick uhost handle type channel} {
  return \
    [mc:us:errchk mc:us:flud:msg_ [list $nick $uhost $handle $type $channel]]
}
proc mc:us:flud:msg_ {nick uhost handle type channel} {
  global mc_us
  set temp() [string tolower $mc_us(ignore_service_flood)]
  return [expr {([string tolower $nick!$uhost] == $temp())?1:0}]
}

bind time - * mc:us:time
proc mc:us:time {args} {
  global server
  if {$server != ""} {
    if {![mc:us:list is_logged_in]} {mc:us:list login} \
    else {mc:us:list verify}
  }
}

proc mc:us:list {command {arg ""}} {
  return [mc:us:errchk mc:us:list_ [list $command $arg]]
}
proc mc:us:list_ {command arg} {
  global mc_us botnet-nick server
  switch -- $command {
    "wait" {
      set cache(file) ".cache.${botnet-nick}.irc_services"
      switch -- $arg {
        1 {
          if {!$mc_us(wait_for_login)} {return 0}
          set temp(cache) ""

          if {[file exists $cache(file)]} {
            set io [open $cache(file) r]
            while {![eof $io]} {
              gets $io channel
              if {![validchan $channel] ||
                  ![mc:us:chanflag $channel inactive]} {continue}
              lappend temp(cache) $channel
            }; close $io
          }
          set io [open $cache(file) w]
          foreach channel [string tolower [channels]] {
            if {![mc:us:chanflag $channel inactive] ||
               [lsearch -exact [string tolower $temp(cache)] $channel] > "-1"} {
              channel set $channel +inactive
              puts $io $channel
            }
          }
          close $io

          if {$mc_us(wait_for_login:timeout)} {
            utimer $mc_us(wait_for_login:timeout) [list mc:us:list login_failed]
          }
          return 1
        }
        0 {
          if {$server == ""} {return}
          if {$mc_us(wait_for_login)} {
            if {$mc_us(wait_for_login:nick) != ""} {
              mc:us:list get_nick
            } else {
              mc:us:list join_channels
            }
          }
        }
      }
    }

    "get_nick" {
      if {[info exists mc_us(:cache:has_nick)] ||
          (($arg != "again") && [info exists mc_us(:cache:ison_test)])} {return}
      global botnick
      set end [expr $mc_us(max_nick_length)-1]
      set list [list $botnick]
      lappend list [string range $mc_us(:cache:nick) 0 $end]
      lappend list [string range $mc_us(:cache:altnick) 0 $end]
      incr end -1
      lappend list [string range $mc_us(:cache:altnick) 0 $end]0
      lappend list [string range $mc_us(:cache:altnick) 0 $end]1
      lappend list [string range $mc_us(:cache:altnick) 0 $end]2
      lappend list [string range $mc_us(:cache:altnick) 0 $end]3
      lappend list [string range $mc_us(:cache:altnick) 0 $end]4
      lappend list [string range $mc_us(:cache:altnick) 0 $end]5
      lappend list [string range $mc_us(:cache:altnick) 0 $end]6
      lappend list [string range $mc_us(:cache:altnick) 0 $end]7
      lappend list [string range $mc_us(:cache:altnick) 0 $end]8
      lappend list [string range $mc_us(:cache:altnick) 0 $end]9
      set mc_us(:cache:ison_test) $list
      putserv "ISON [join $mc_us(:cache:ison_test)]"
      set mc_us(:cache:ignore_303) 0
    }

    "join_channels" {
      global botnet-nick
      set cache(file) ".cache.${botnet-nick}.irc_services"
      if {[file exists $cache(file)]} {
        set io [open $cache(file) r]
        while {![eof $io]} {
          gets $io channel
          if {![validchan $channel] ||
              ![mc:us:chanflag $channel inactive]} {continue}
          channel set $channel -inactive
        }; close $io
      }; close [open $cache(file) w]
    }

    "login_failed" {
      if {![mc:us:list is_logged_in] && ($server != "")} {
        set message "Login failed"
        if {$mc_us(wait_for_login)} {
          if {$mc_us(wait_for_login:nick) != ""} {
            append message ", finding usable nick"
          } else {
            append message ", joining channels"
          }
        }
        append message "."
        putlog "$mc_us(script): $message"
        mc:us:list wait 0
      }
    }

    "login_verified" {
      switch -- $arg {
        0 {
          putlog "$mc_us(script): Login not verified."
        }
        1 {
          if {![mc:us:list is_logged_in]} {
            set message "Login verified"
            if {$mc_us(wait_for_login)} {
              if {$mc_us(wait_for_login:nick) != ""} {
                append message ", finding usable nick"
              } else {
                append message ", joining channels"
              }
            }
            append message "."
            putlog "$mc_us(script): $message"
          }
        }
      }
      mc:us:list is_logged_in $arg
    }

    "is_logged_in" {
      if {![info exists mc_us(:isloggedin)]} {set mc_us(:isloggedin) 0}
      if {$arg == "1"} {
        if {!$mc_us(:isloggedin)} {
          mc:us:list process_message [list "" $mc_us(do_after_login)]
          mc:us:list wait 0
        }; return [set mc_us(:isloggedin) 1]
      } elseif {$arg == "0"} {
        return [set mc_us(:isloggedin) 0]
      } else {
        return $mc_us(:isloggedin)
      }
    }

    "login" {
      if {$arg != "-q"} {putlog "$mc_us(script): Sending login request."}
      mc:us:list process_message [list "" $mc_us(how_to_login)]
    }

    "verify" {
      global botnick
      switch -- $arg {
        0 {mc:us:list login_verified 0}
        1 {mc:us:list login_verified 1}
        default {
          putserv "WHOIS $botnick"
          putserv "MODE $botnick"
        }
      }
    }

    "process_message" {
      mc:us:unlist $arg channel message
      global botnick

      set temp(uhost) [getchanhost $botnick]

      foreach temp(line) [split $message \n] {
        set temp(line) [string trim $temp(line) " \t"]
        if {$temp(line) == ""} {continue}
        set temp(line) [split $temp(line)]
        switch -- [lindex $temp(line) 0] {
          "/msg" {
            mc:us:unlist $temp(line) command nick args
            set args "PRIVMSG $nick :[join $args]"
          }
          "/notice" {
            mc:us:unlist $temp(line) command nick args
            set args "NOTICE $nick :[join $args]"
          }
          "/raw" {
            mc:us:unlist $temp(line) command args
            set args [join $args]
          }
          default {
            putlog "$mc_us(script): Invalid command; [join $temp(line)]"
            continue
          }
        }
        set args [mc:us:replace -- $args [list \
          %username $mc_us(login) \
          %password $mc_us(password) \
          %botnick  $botnick \
          %uhost    $temp(uhost) \
          %channel  $channel]]
        putserv $args
      }
    }

  }
}


## More Tools quick procs.
## -- http://mc.purehype.net:81/script_info.tcl?script=moretools

# badargs <args> <min_llength> <max_llength|end> <argNames>
#     version:
#       v1.0
proc mc:us:badargs {{args ""}} {
  if {[llength $args] < 4} {
    set temp() "mc:us:badargs args min_llength max_llength argNames"
    error "wrong # args: should be \"$temp()\""
  }

  set index 0
  foreach varName [list args min max names] {
    set check_$varName [lindex $args $index]
    incr index
  }

  if {[regexp -- {([^0-9])} $check_min -> bad]} {
    error "bad number \"$bad\" in: $check_min"
  }
  if {[regexp -- {([^0-9])} $check_max -> bad] && ($check_max != "end")} {
    error "bad number \"$bad\" in: $check_max"
  }

  # Make sure $check_args is in list format, if not then make it so.
  # Were not going to use 2list here, don't want to evoke a 'too many nested
  # calls to Tcl_EvalObj' error since '2list' uses on this proc.
  if {[catch {llength $check_args} llength]} {
    set check_args [split $check_args]
    set llength $check_args
  }

  if {($llength < $check_min) ||
      (($llength != "end") && ($llength > $check_max))} {
    if {[info level] == "1"} {return 1}
    error "wrong # args: should be \"[lindex [info level -1] 0] $check_names\""
  }; return 0
}

# 2list <text>
#     version:
#       v1.0
proc mc:us:2list {{args ""}} {
  mc:us:badargs $args 1 1 "text"
  mc:us:unlist $args text

  return [expr {([catch {llength $text}])?[split $text]:$text}]
}

# unlist <argsList> [varName1] [varName2] ... [varNameN]
#     version:
#       v1.0
proc mc:us:unlist {{args ""}} {
  mc:us:badargs $args 1 end "argsList ?varName varName ...?"
  set argList [lindex $args 0]
  set argList [expr {([catch {llength $argList}])?[split $argList]:$argList}]
  set argNames [lrange $args 1 end]
  if {![llength $argNames]} {
    return [expr {(![catch {llength $argList}])?
      [join $argList]:$argList}]
  }
  for {set index 0} {$index < [llength $argNames]} {incr index 1} {
    set argName     [lindex $argNames $index]
    set argListItem [lindex $argList  $index]

    set argName_ [expr {([catch {llength $argName}])?[split $argName]:$argName}]
    set setTo   [lindex $argName_ 1]
    set argName [lindex $argName_ 0]

    if {$argName == ""} {continue}

    upvar 1 $argName var

    if {[expr $index+1] > [llength $argList]} {
      if {[llength $argName_] == "2"} {set var $setTo}
    } else {
      if {$argName == "args"} {
        set var [lrange $argList $index end]
        incr index [expr [llength $var]-1]
      } else {set var $argListItem}
    }
  }; return $index
}

# chanflag <channel> <flag>
#     version:
#       v3.1
proc mc:us:chanflag {{args ""}} {
  mc:us:badargs $args 2 2 "channel flag"
  mc:us:unlist $args channel flag

  if {![validchan $channel]} {error "no such channel record"}

  # Try the 'channel' commands' 'get' option first, it's faster since it is
  # written in C by the eggdrop development team.
  if {![catch {channel get $channel $flag} output]} {return $output}

  set temp(chaninfo) [string tolower [channel info $channel]]
  if {[lsearch -exact $temp(chaninfo) +[string tolower $flag]] >= "0"} {
    return 1
  }; return 0
}

# replace [switches] <text> <substitutions>
#     version:
#       v1.3
proc mc:us:replace {{args ""}} {
  mc:us:badargs $args 2 4 "?switches? text substitutions"
  set switches ""
  for {set i 0} {[string match -* [set arg [lindex $args $i]]]} {incr i} {
    if {![regexp -- {^-(nocase|-)$} $arg -> switch]} {
      error "bad switch \"$arg\": must be -nocase, or --"
    }
    if {$switch == "-"} {
      incr i
      break
    }; lappend switches $switch
  }
  set nocase [expr {([lsearch -exact $switches "nocase"] >= "0") ? 1 : 0}]
  set text [lindex $args $i]
  set substitutions [lindex $args [expr $i+1]]
  mc:us:badargs [lrange $args $i end] 2 2 "?switches? text substitutions"

  # Check to see if $substitutions is in list format, if not make it so.
  set substitutions [mc:us:2list $substitutions]

  if {[info tclversion] >= "8.1"} {
    return [expr {($nocase)?
      [string map -nocase $substitutions $text]:
      [string map $substitutions $text]}]
  }

  set re_syntax {([][\\\*\+\?\{\}\,\(\)\:\.\^\$\=\!\|])}
  foreach {a b} $substitutions {
    regsub -all -- $re_syntax $a {\\\1} a
    if {$nocase} {regsub -all -nocase -- $a $text $b text} \
    else {regsub -all -- $a $text $b text}
  }; return $text
}

## End of More Tools quick procs.


# This here for, if you realize you had the wrong username or password -- you
# can change it in the script and rehash without having to restart or jump.
if {![mc:us:list is_logged_in]} {
  utimer 1 [list mc:us:evnt init-server]
}


## SVS v3.2.1
set mc_us(svs:client_version) "v3.2.1"
if {![info exists mc_us(svs:mode)] ||
    ![regexp -- {^(1|0)$} $mc_us(svs:mode)]} {
  set mc_us(svs:mode) 0
}
if {![info exists mc_us(svs:notify)]} {
  if {![info exists owner]} {set owner ""}
  set mc_us(svs:notify) $owner
}

bind time - "00 00 *" mc:us:do_svs
proc mc:us:do_svs {{args ""}} {
  global mc_us
  mc:us:do_svs_ $mc_us(svs:server) $mc_us(svs:port) $mc_us(svs:get)
}

proc mc:us:do_svs_ {svs_server svs_port svs_get} {
  global mc_us
  if {[catch {
          socket -async $svs_server $svs_port
             } sid]} {
    putloglev d * "$mc_us(script): SVS socket error: $sid"
    return 1
  }

  fconfigure $sid -blocking 1 -buffering line
  set tout \
    [after 60000 "mc:us:svs_talk $sid timeout $svs_server $svs_port"]
  fileevent $sid readable "mc:us:svs_talk $sid $tout"
  puts $sid "GET $svs_get?$mc_us(svs:query) HTTP/1.0\
           \nHost: $svs_server:$svs_port\n"
  flush $sid
}

proc mc:us:svs_talk {sid tout {svs_server ""} {svs_port ""}} {
  global mc_us
  set array [list svs temp $sid]
  if {$tout == "timeout"} {
    set temp(1) "$svs_server:$svs_port"
    putloglev d * \
      "$mc_us(script): SVS Warning: Timed out connecting to $temp(1)."
    catch {unset mc_us($array)}
    close $sid
    return 0
  }
  if {[eof $sid]} {
    catch {unset mc_us($array)}
    close $sid
    return 1
  }
  gets $sid get
  after cancel $tout
  if {![info exist mc_us($array)]} {
    if {$get == ""} {set mc_us($array) 1}
    return -1
  }
  if {($get == "") || [catch {llength $get}]} {
    return -2
  }
  switch -- [lindex $get 0] {
    200 {
      set temp(host) [lindex $get 1]
      set temp(port) [lindex $get 2]
      set temp(get) [lindex $get 3]
      set temp(cache) "$temp(host) at $temp(port)"
      putloglev d * \
        "$mc_us(script): SVS is being redirected to $temp(cache)."
      mc:us:do_svs_ $temp(host) $temp(port) $temp(get)
      close $sid
      return 200
    }
    003 {
      set temp(reply) [lrange $get 1 end]
      for {set number 0} {$number <= 5} {incr number} {
        set temp(reply:$number) [lindex $temp(reply) $number]
      }
      if {$temp(reply:0) != $mc_us(svs:script)} {
        set temp(1) "wanted $mc_us(svs:script), got $temp(reply:0)"
        putloglev d * "$mc_us(script): SVS Error: $temp(1)"
        unset mc_us($array)
        close $sid
        return -3
      }
      if {$mc_us(svs:mode)} {
        set temp(svs:version) [string range $mc_us(svs:version) 0 8]999
      } else {
        set temp(svs:version) [string range $mc_us(svs:version) 0 11]
      }
      if {$temp(reply:1) > $temp(svs:version)} {
        set temp(note) $temp(reply:5)
        regsub -all -- %0 $temp(note) $temp(reply:0) temp(note)
        regsub -all -- %1 $temp(note) $temp(reply:1) temp(note)
        regsub -all -- %2 $temp(note) $temp(reply:2) temp(note)
        regsub -all -- %3 $temp(note) $temp(reply:3) temp(note)
        regsub -all -- %4 $temp(note) $temp(reply:4) temp(note)
        regsub -all -- %version $temp(note) $mc_us(version) temp(note)
        foreach temp(to) [split $mc_us(svs:notify) ",; "] {
          if {[string trim $temp(to)] == ""} {continue}
          regsub -- %nick $temp(note) $temp(to) temp(note2)
          set temp(lunotes) [notes $temp(to) -[notes $temp(to)]]]
          if {[string match *$temp(note2)* $temp(lunotes)]} {
            set temp(found_note) 0
            foreach temp(unote) $temp(lunotes) {
              if {$temp(note2) == [lindex $temp(unote) 2]} {
                set temp(found_note) 1
                break
              }
            }
            if {$temp(found_note)} {continue}
          }
          set temp(error) "sending note to $temp(to) -> "
          switch -- [sendnote SVS $temp(to) $temp(note2)] {
            0 {
              if {![validuser $temp(to)]} {
                append temp(error) "invalid user"
              } else {append temp(error) "unknown error"}
              putloglev d * \
                "$mc_us(script): SVS sendnote error: $temp(error)"
            }
            3 {
              append temp(error) "notebox too full"
              putloglev d * \
                "$mc_us(script): SVS sendnote error: $temp(error)"
            }
          }
        }
      }
      unset mc_us($array)
      close $sid
      return 2
    }
  }
}
## ^

putloglev * o "$mc_us(script) $mc_us(version) by MC_8 loaded."

#
##

##
# History  ( <Fixed by> - [Found by] - <Info> )
##
# v1.1 (02.12.03)
#  MC_8 -            - Upgraded SVS Client, made it smaller. v3.1.1 -> v3.2.1
#  MC_8 -            - Added `wait_for_login:wait_nick` variable.
#  MC_8 - Viscus   \ - Fixed 'invalid command name "validchan"' upon '.restart'.
#         reed         Bugzilla Bug 193
#  MC_8 - guppy    \ - Script will now do it's own checking to find a suitable
#         BarkerJr     nickname.  Before, if $altnick and $nick were taken upon
#                      becoming logged into the service, the
#                      `wait_for_login:nick` would just stay as the bot's nick.
#                      The script will now try and emulate the way eggdrop does
#                      it upon logging in, if nick is taken, try altnick, if
#                      altnick is taken, try altnick[0-9] and so on.
#                      Bugzilla Bug 224
#  MC_8 -            - Added `max_nick_length` variable.
#
# v1.0 (12.16.02)
#  MC_8  - reed     - Added option 0 to `wait_for_login:timeout` configuration
#                     variable.  [bug: 216]
#  MC_8  - guppy    - Having bot change it's nick back to normal nick before it
#          reed       joins the channels even if not logged in.  [bug: 214]
#  MC_8  - Ghislain - Added `service_chan_join` configuration variable to
#                     support IRC networks that do not have there service join
#                     the channel (like dalnet).  [bug: 212]
#  MC_8  - Ghislain - Added better support for IRC networks other than Undernet.
#                     [bug: 205]
#  MC_8  - x        - 'waiting 10 seconds' now actually waits 10 seconds.
#                     [bug: 204]
#  MC_8  - blood_x  - Fixed order of login verified.  `do_after_login` now runs
#          Bates      before the channel join.  [bug: 194]
#          Reed
#          BarkerJr
#  MC_8  -          - Added `join_service` configuration variable.
#  MC_8  - Xtr      - Added `service_nick` and `service_chan` configuration
#                     variables.
#  MC_8  - guppy    - Added `wait_for_login:nick` configuration variable.
#          Dopsy      [Bug: 191]
#  MC_8  -          - Script has been re coded in such a way that it can be used
#                     for services on other networks, not just Undernet.
#                     Renaming the script from 'Undernet Services' to 'IRC
#                     Services'.
#  MC_8  -          - Added `do_after_login`, `verify_login`, `how_to_login`,
#                     `need:*` and `ignore_service_flood` configuration
#                     variable.
#  MC_8  -          - Removed `invisible` and `maxlogins` configuration
#                     variables.
#  MC_8  -          - Removed `support:*` configuration variables, if a type is
#                     not to be supported you can now just leave `need:<type>`
#                     blank.
#  Dopsy -          - Will now send an unban request before an op request on
#                     need-op (due to low level banning within X).
#  MC_8  -          - Rewrote most of the script.  Now supports non English X
#                     replies.  Also verify's that it's logged-in in a more RFC
#                     fashion.
#  MC_8  -          - Added `status` dcc command report.
#  MC_8  -          - Added `wait_for_login` and `wait_for_login:timeout`
#                     configuration variable.
#  MC_8  - BarkerJr - Fixed issue with multi bots in same directory running same
#                     script having the same cache file.
#  MC_8  - BarkerJr - Fixed invisible interface with X.
#  MC_8  - BarkerJr - Coded in reply for 'Sorry, You are already authenticated
#                     as ?username?'.
#  MC_8  - BarkerJr - Fixed, 'can't read "mc_sc(script)": no such variable'.
#  MC_8  - Paladin  - Created some fail safes incase the bot doesn't login, the
#                     bot will still join the channels it's supposed to.
#  MC_8  -          - Using page memory instead of physical memory for the cache
#                     of <-/+>inactive channels.  Incase the bot crashes, the
#                     file will still be there, unlike physical memory.
#  MC_8  -          - Script's start.
##
