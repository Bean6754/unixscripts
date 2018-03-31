#!/bin/bash

# Needs Bash for Homebrew script to run.

# Xcode dependancies.
xcode-select --install # Install Command Line Tools if you haven't already.
sudo xcode-select --switch /Library/Developer/CommandLineTools # Enable command line tools.
# sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# Install Homebrew.
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Update system.
brew update
brew upgrade



## Setup GNU coreutils and similar.
echo 'export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH"' >> ~/.bash_profile
echo 'export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH"' >> ~/.zshrc
# Fix Vim backspace issue.
echo "set backspace=2" >> ~/.vimrc

brew install coreutils
brew install binutils
brew install diffutils
brew install ed --with-default-names
brew install findutils --with-default-names
brew install gawk
brew install gnu-indent --with-default-names
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-which --with-default-names
brew install gnutls
brew install grep --with-default-names
brew install gzip
brew install screen
brew install watch
brew install wdiff --with-gettext
brew install wget
brew install bash
brew install emacs
brew install gdb  # gdb requires further actions to make it work. See `brew info gdb`.
brew install gpatch
brew install less
brew install m4
brew install make
brew install nano
brew install file-formula
brew install git
brew install openssh
brew install perl
brew install python
brew install rsync
brew install svn
brew install unzip
brew install vim --with-override-system-vi
# brew install macvim --with-override-system-vim --custom-system-icons
brew install zsh

# Setup bash for local user.
sudo bash -c 'cat >> /etc/shells << EOF

# Brew.
/usr/local/bin/bash
EOF'
chsh -s /usr/local/bin/bash



# git curl wget python, already installed from Xcode utils.
brew install arping arpoison arp-scan ettercap htop iftop lua neofetch nmap nethogs python2 python3 telnet tmux zsh
# Rust tools.
brew install exa fd
# Security.
brew install clamav
# Cask(room) stuff. Usually graphical applications.
brew tap caskroom/cask
brew cask install iterm2 mpv transmission


## clamav stuff.
# conf.
cat > /usr/local/etc/clamav/freshclam.conf << EOF
##
## Example config file for freshclam
## Please read the freshclam.conf(5) manual before editing this file.
##


# Comment or remove the line below.
# Example

# Path to the database directory.
# WARNING: It must match clamd.conf's directive!
# Default: hardcoded (depends on installation options)
#DatabaseDirectory /var/lib/clamav

# Path to the log file (make sure it has proper permissions)
# Default: disabled
UpdateLogFile /usr/local/var/log/freshclam.log

# Maximum size of the log file.
# Value of 0 disables the limit.
# You may use 'M' or 'm' for megabytes (1M = 1m = 1048576 bytes)
# and 'K' or 'k' for kilobytes (1K = 1k = 1024 bytes).
# in bytes just don't use modifiers. If LogFileMaxSize is enabled,
# log rotation (the LogRotate option) will always be enabled.
# Default: 1M
LogFileMaxSize 2M

# Log time with each message.
# Default: no
LogTime yes

# Enable verbose logging.
# Default: no
LogVerbose yes

# Use system logger (can work together with UpdateLogFile).
# Default: no
#LogSyslog yes

# Specify the type of syslog messages - please refer to 'man syslog'
# for facility names.
# Default: LOG_LOCAL6
#LogFacility LOG_MAIL

# Enable log rotation. Always enabled when LogFileMaxSize is enabled.
# Default: no
#LogRotate yes

# This option allows you to save the process identifier of the daemon
# Default: disabled
#PidFile /var/run/freshclam.pid

# By default when started freshclam drops privileges and switches to the
# "clamav" user. This directive allows you to change the database owner.
# Default: clamav (may depend on installation options)
#DatabaseOwner clamav

# Initialize supplementary group access (freshclam must be started by root).
# Default: no
#AllowSupplementaryGroups yes

# Use DNS to verify virus database version. Freshclam uses DNS TXT records
# to verify database and software versions. With this directive you can change
# the database verification domain.
# WARNING: Do not touch it unless you're configuring freshclam to use your
# own database verification domain.
# Default: current.cvd.clamav.net
#DNSDatabaseInfo current.cvd.clamav.net

# Uncomment the following line and replace XY with your country
# code. See http://www.iana.org/cctld/cctld-whois.htm for the full list.
# You can use db.XY.ipv6.clamav.net for IPv6 connections.
#DatabaseMirror db.XY.clamav.net

# database.clamav.net is a round-robin record which points to our most 
# reliable mirrors. It's used as a fall back in case db.XY.clamav.net is 
# not working. DO NOT TOUCH the following line unless you know what you
# are doing.
DatabaseMirror database.clamav.net

# How many attempts to make before giving up.
# Default: 3 (per mirror)
#MaxAttempts 5

# With this option you can control scripted updates. It's highly recommended
# to keep it enabled.
# Default: yes
#ScriptedUpdates yes

# By default freshclam will keep the local databases (.cld) uncompressed to
# make their handling faster. With this option you can enable the compression;
# the change will take effect with the next database update.
# Default: no
#CompressLocalDatabase no

# With this option you can provide custom sources (http:// or file://) for
# database files. This option can be used multiple times.
# Default: no custom URLs
#DatabaseCustomURL http://myserver.com/mysigs.ndb
#DatabaseCustomURL file:///mnt/nfs/local.hdb

# This option allows you to easily point freshclam to private mirrors.
# If PrivateMirror is set, freshclam does not attempt to use DNS
# to determine whether its databases are out-of-date, instead it will
# use the If-Modified-Since request or directly check the headers of the
# remote database files. For each database, freshclam first attempts
# to download the CLD file. If that fails, it tries to download the
# CVD file. This option overrides DatabaseMirror, DNSDatabaseInfo
# and ScriptedUpdates. It can be used multiple times to provide
# fall-back mirrors.
# Default: disabled
#PrivateMirror mirror1.mynetwork.com
#PrivateMirror mirror2.mynetwork.com

# Number of database checks per day.
# Default: 12 (every two hours)
#Checks 24

# Proxy settings
# Default: disabled
#HTTPProxyServer myproxy.com
#HTTPProxyPort 1234
#HTTPProxyUsername myusername
#HTTPProxyPassword mypass

# If your servers are behind a firewall/proxy which applies User-Agent
# filtering you can use this option to force the use of a different
# User-Agent header.
# Default: clamav/version_number
#HTTPUserAgent SomeUserAgentIdString

# Use aaa.bbb.ccc.ddd as client address for downloading databases. Useful for
# multi-homed systems.
# Default: Use OS'es default outgoing IP address.
#LocalIPAddress aaa.bbb.ccc.ddd

# Send the RELOAD command to clamd.
# Default: no
#NotifyClamd /path/to/clamd.conf

# Run command after successful database update.
# Default: disabled
#OnUpdateExecute command

# Run command when database update process fails.
# Default: disabled
#OnErrorExecute command

# Run command when freshclam reports outdated version.
# In the command string %v will be replaced by the new version number.
# Default: disabled
#OnOutdatedExecute command

# Don't fork into background.
# Default: no
#Foreground yes

# Enable debug messages in libclamav.
# Default: no
#Debug yes

# Timeout in seconds when connecting to database server.
# Default: 30
#ConnectTimeout 60

# Timeout in seconds when reading from database server.
# Default: 30
#ReceiveTimeout 60

# With this option enabled, freshclam will attempt to load new
# databases into memory to make sure they are properly handled
# by libclamav before replacing the old ones.
# Default: yes
#TestDatabases yes

# When enabled freshclam will submit statistics to the ClamAV Project about
# the latest virus detections in your environment. The ClamAV maintainers
# will then use this data to determine what types of malware are the most
# detected in the field and in what geographic area they are.
# Freshclam will connect to clamd in order to get recent statistics.
# Default: no
#SubmitDetectionStats /path/to/clamd.conf

# Country of origin of malware/detection statistics (for statistical
# purposes only). The statistics collector at ClamAV.net will look up
# your IP address to determine the geographical origin of the malware
# reported by your installation. If this installation is mainly used to
# scan data which comes from a different location, please enable this
# option and enter a two-letter code (see http://www.iana.org/domains/root/db/)
# of the country of origin.
# Default: disabled
#DetectionStatsCountry country-code

# This option enables support for our "Personal Statistics" service. 
# When this option is enabled, the information on malware detected by
# your clamd installation is made available to you through our website.
# To get your HostID, log on http://www.stats.clamav.net and add a new
# host to your host list. Once you have the HostID, uncomment this option
# and paste the HostID here. As soon as your freshclam starts submitting
# information to our stats collecting service, you will be able to view
# the statistics of this clamd installation by logging into
# http://www.stats.clamav.net with the same credentials you used to
# generate the HostID. For more information refer to:
# http://www.clamav.net/documentation.html#cctts 
# This feature requires SubmitDetectionStats to be enabled.
# Default: disabled
#DetectionStatsHostID unique-id

# This option enables support for Google Safe Browsing. When activated for
# the first time, freshclam will download a new database file (safebrowsing.cvd)
# which will be automatically loaded by clamd and clamscan during the next
# reload, provided that the heuristic phishing detection is turned on. This
# database includes information about websites that may be phishing sites or
# possible sources of malware. When using this option, it's mandatory to run
# freshclam at least every 30 minutes.
# Freshclam uses the ClamAV's mirror infrastructure to distribute the
# database and its updates but all the contents are provided under Google's
# terms of use. See http://www.google.com/transparencyreport/safebrowsing
# and http://www.clamav.net/documentation.html#safebrowsing 
# for more information.
# Default: disabled
#SafeBrowsing yes

# This option enables downloading of bytecode.cvd, which includes additional
# detection mechanisms and improvements to the ClamAV engine.
# Default: enabled
#Bytecode yes

# Download an additional 3rd party signature database distributed through
# the ClamAV mirrors. 
# This option can be used multiple times.
#ExtraDatabase dbname1
#ExtraDatabase dbname2
EOF
# freshclam log.
mkdir -p /usr/local/var/log
touch /usr/local/var/log/freshclam.log
# clamd.
cat > /usr/local/etc/clamav/clamd.conf << EOF
##
## Example config file for the Clam AV daemon
## Please read the clamd.conf(5) manual before editing this file.
##


# Comment or remove the line below.
# Example

# Uncomment this option to enable logging.
# LogFile must be writable for the user running daemon.
# A full path is required.
# Default: disabled
LogFile /tmp/clamd.log

# By default the log file is locked for writing - the lock protects against
# running clamd multiple times (if want to run another clamd, please
# copy the configuration file, change the LogFile variable, and run
# the daemon with --config-file option).
# This option disables log file locking.
# Default: no
#LogFileUnlock yes

# Maximum size of the log file.
# Value of 0 disables the limit.
# You may use 'M' or 'm' for megabytes (1M = 1m = 1048576 bytes)
# and 'K' or 'k' for kilobytes (1K = 1k = 1024 bytes). To specify the size
# in bytes just don't use modifiers. If LogFileMaxSize is enabled, log
# rotation (the LogRotate option) will always be enabled.
# Default: 1M
LogFileMaxSize 2M

# Log time with each message.
# Default: no
LogTime yes

# Also log clean files. Useful in debugging but drastically increases the
# log size.
# Default: no
#LogClean yes

# Use system logger (can work together with LogFile).
# Default: no
#LogSyslog yes

# Specify the type of syslog messages - please refer to 'man syslog'
# for facility names.
# Default: LOG_LOCAL6
#LogFacility LOG_MAIL

# Enable verbose logging.
# Default: no
LogVerbose yes

# Enable log rotation. Always enabled when LogFileMaxSize is enabled.
# Default: no
#LogRotate yes

# Log additional information about the infected file, such as its
# size and hash, together with the virus name.
#ExtendedDetectionInfo yes

# This option allows you to save a process identifier of the listening
# daemon (main thread).
# Default: disabled
#PidFile /var/run/clamd.pid

# Optional path to the global temporary directory.
# Default: system specific (usually /tmp or /var/tmp).
#TemporaryDirectory /var/tmp

# Path to the database directory.
# Default: hardcoded (depends on installation options)
#DatabaseDirectory /var/lib/clamav

# Only load the official signatures published by the ClamAV project.
# Default: no
#OfficialDatabaseOnly no

# The daemon can work in local mode, network mode or both. 
# Due to security reasons we recommend the local mode.

# Path to a local socket file the daemon will listen on.
# Default: disabled (must be specified by a user)
#LocalSocket /tmp/clamd.socket

# Sets the group ownership on the unix socket.
# Default: disabled (the primary group of the user running clamd)
#LocalSocketGroup virusgroup

# Sets the permissions on the unix socket to the specified mode.
# Default: disabled (socket is world accessible)
#LocalSocketMode 660

# Remove stale socket after unclean shutdown.
# Default: yes
#FixStaleSocket yes

# TCP port address.
# Default: no
#TCPSocket 3310

# TCP address.
# By default we bind to INADDR_ANY, probably not wise.
# Enable the following to provide some degree of protection
# from the outside world. This option can be specified multiple
# times if you want to listen on multiple IPs. IPv6 is now supported.
# Default: no
#TCPAddr 127.0.0.1

# Maximum length the queue of pending connections may grow to.
# Default: 200
#MaxConnectionQueueLength 30

# Clamd uses FTP-like protocol to receive data from remote clients.
# If you are using clamav-milter to balance load between remote clamd daemons
# on firewall servers you may need to tune the options below.

# Close the connection when the data size limit is exceeded.
# The value should match your MTA's limit for a maximum attachment size.
# Default: 25M
#StreamMaxLength 10M

# Limit port range.
# Default: 1024
#StreamMinPort 30000
# Default: 2048
#StreamMaxPort 32000

# Maximum number of threads running at the same time.
# Default: 10
#MaxThreads 20

# Waiting for data from a client socket will timeout after this time (seconds).
# Default: 120
#ReadTimeout 300

# This option specifies the time (in seconds) after which clamd should
# timeout if a client doesn't provide any initial command after connecting.
# Default: 5
#CommandReadTimeout 5

# This option specifies how long to wait (in miliseconds) if the send buffer is full.
# Keep this value low to prevent clamd hanging
#
# Default: 500
#SendBufTimeout 200

# Maximum number of queued items (including those being processed by MaxThreads threads)
# It is recommended to have this value at least twice MaxThreads if possible.
# WARNING: you shouldn't increase this too much to avoid running out  of file descriptors,
# the following condition should hold:
# MaxThreads*MaxRecursion + (MaxQueue - MaxThreads) + 6< RLIMIT_NOFILE (usual max is 1024)
#
# Default: 100
#MaxQueue 200

# Waiting for a new job will timeout after this time (seconds).
# Default: 30
#IdleTimeout 60

# Don't scan files and directories matching regex
# This directive can be used multiple times
# Default: scan all
#ExcludePath ^/proc/
#ExcludePath ^/sys/

# Maximum depth directories are scanned at.
# Default: 15
#MaxDirectoryRecursion 20

# Follow directory symlinks.
# Default: no
#FollowDirectorySymlinks yes

# Follow regular file symlinks.
# Default: no
#FollowFileSymlinks yes

# Scan files and directories on other filesystems.
# Default: yes
#CrossFilesystems yes

# Perform a database check.
# Default: 600 (10 min)
#SelfCheck 600

# Execute a command when virus is found. In the command string %v will
# be replaced with the virus name.
# Default: no
#VirusEvent /usr/local/bin/send_sms 123456789 "VIRUS ALERT: %v"

# Run as another user (clamd must be started by root for this option to work)
# Default: don't drop privileges
#User clamav

# Initialize supplementary group access (clamd must be started by root).
# Default: no
#AllowSupplementaryGroups no

# Stop daemon when libclamav reports out of memory condition.
#ExitOnOOM yes

# Don't fork into background.
# Default: no
#Foreground yes

# Enable debug messages in libclamav.
# Default: no
#Debug yes

# Do not remove temporary files (for debug purposes).
# Default: no
#LeaveTemporaryFiles yes

# Permit use of the ALLMATCHSCAN command. If set to no, clamd will reject
# any ALLMATCHSCAN command as invalid.
# Default: yes
#AllowAllMatchScan no

# Detect Possibly Unwanted Applications.
# Default: no
#DetectPUA yes

# Exclude a specific PUA category. This directive can be used multiple times.
# See https://github.com/vrtadmin/clamav-faq/blob/master/faq/faq-pua.md for 
# the complete list of PUA categories.
# Default: Load all categories (if DetectPUA is activated)
#ExcludePUA NetTool
#ExcludePUA PWTool

# Only include a specific PUA category. This directive can be used multiple
# times.
# Default: Load all categories (if DetectPUA is activated)
#IncludePUA Spy
#IncludePUA Scanner
#IncludePUA RAT

# In some cases (eg. complex malware, exploits in graphic files, and others),
# ClamAV uses special algorithms to provide accurate detection. This option
# controls the algorithmic detection.
# Default: yes
#AlgorithmicDetection yes

# This option causes memory or nested map scans to dump the content to disk.
# If you turn on this option, more data is written to disk and is available
# when the LeaveTemporaryFiles option is enabled.
#ForceToDisk yes

# This option allows you to disable the caching feature of the engine. By
# default, the engine will store an MD5 in a cache of any files that are
# not flagged as virus or that hit limits checks. Disabling the cache will
# have a negative performance impact on large scans.
# Default: no
#DisableCache yes

##
## Executable files
##

# PE stands for Portable Executable - it's an executable file format used
# in all 32 and 64-bit versions of Windows operating systems. This option allows
# ClamAV to perform a deeper analysis of executable files and it's also
# required for decompression of popular executable packers such as UPX, FSG,
# and Petite. If you turn off this option, the original files will still be
# scanned, but without additional processing.
# Default: yes
#ScanPE yes

# Certain PE files contain an authenticode signature. By default, we check
# the signature chain in the PE file against a database of trusted and
# revoked certificates if the file being scanned is marked as a virus.
# If any certificate in the chain validates against any trusted root, but
# does not match any revoked certificate, the file is marked as whitelisted.
# If the file does match a revoked certificate, the file is marked as virus.
# The following setting completely turns off authenticode verification.
# Default: no
#DisableCertCheck yes

# Executable and Linking Format is a standard format for UN*X executables.
# This option allows you to control the scanning of ELF files.
# If you turn off this option, the original files will still be scanned, but
# without additional processing.
# Default: yes
#ScanELF yes

# With this option clamav will try to detect broken executables (both PE and
# ELF) and mark them as Broken.Executable.
# Default: no
#DetectBrokenExecutables yes


##
## Documents
##

# This option enables scanning of OLE2 files, such as Microsoft Office
# documents and .msi files.
# If you turn off this option, the original files will still be scanned, but
# without additional processing.
# Default: yes
#ScanOLE2 yes

# With this option enabled OLE2 files with VBA macros, which were not
# detected by signatures will be marked as "Heuristics.OLE2.ContainsMacros".
# Default: no
#OLE2BlockMacros no

# This option enables scanning within PDF files.
# If you turn off this option, the original files will still be scanned, but
# without decoding and additional processing.
# Default: yes
#ScanPDF yes

# This option enables scanning within SWF files.
# If you turn off this option, the original files will still be scanned, but
# without decoding and additional processing.
# Default: yes
#ScanSWF yes

# This option enables scanning xml-based document files supported by libclamav.
# If you turn off this option, the original files will still be scanned, but
# without additional processing.
# Default: yes
#ScanXMLDOCS yes

# This option enables scanning of HWP3 files.
# If you turn off this option, the original files will still be scanned, but
# without additional processing.
# Default: yes
#ScanHWP3 yes


##
## Mail files
##

# Enable internal e-mail scanner.
# If you turn off this option, the original files will still be scanned, but
# without parsing individual messages/attachments.
# Default: yes
#ScanMail yes

# Scan RFC1341 messages split over many emails.
# You will need to periodically clean up $TemporaryDirectory/clamav-partial directory.
# WARNING: This option may open your system to a DoS attack.
#	   Never use it on loaded servers.
# Default: no
#ScanPartialMessages yes

# With this option enabled ClamAV will try to detect phishing attempts by using
# signatures.
# Default: yes
#PhishingSignatures yes

# Scan URLs found in mails for phishing attempts using heuristics.
# Default: yes
#PhishingScanURLs yes

# Always block SSL mismatches in URLs, even if the URL isn't in the database.
# This can lead to false positives.
#
# Default: no
#PhishingAlwaysBlockSSLMismatch no

# Always block cloaked URLs, even if URL isn't in database.
# This can lead to false positives.
#
# Default: no
#PhishingAlwaysBlockCloak no

# Detect partition intersections in raw disk images using heuristics.
# Default: no
#PartitionIntersection no

# Allow heuristic match to take precedence.
# When enabled, if a heuristic scan (such as phishingScan) detects
# a possible virus/phish it will stop scan immediately. Recommended, saves CPU
# scan-time.
# When disabled, virus/phish detected by heuristic scans will be reported only at
# the end of a scan. If an archive contains both a heuristically detected
# virus/phish, and a real malware, the real malware will be reported
#
# Keep this disabled if you intend to handle "*.Heuristics.*" viruses 
# differently from "real" malware.
# If a non-heuristically-detected virus (signature-based) is found first, 
# the scan is interrupted immediately, regardless of this config option.
#
# Default: no
#HeuristicScanPrecedence yes


##
## Data Loss Prevention (DLP)
##

# Enable the DLP module
# Default: No
#StructuredDataDetection yes

# This option sets the lowest number of Credit Card numbers found in a file
# to generate a detect.
# Default: 3
#StructuredMinCreditCardCount 5

# This option sets the lowest number of Social Security Numbers found
# in a file to generate a detect.
# Default: 3
#StructuredMinSSNCount 5

# With this option enabled the DLP module will search for valid
# SSNs formatted as xxx-yy-zzzz
# Default: yes
#StructuredSSNFormatNormal yes

# With this option enabled the DLP module will search for valid
# SSNs formatted as xxxyyzzzz
# Default: no
#StructuredSSNFormatStripped yes


##
## HTML
##

# Perform HTML normalisation and decryption of MS Script Encoder code.
# Default: yes
# If you turn off this option, the original files will still be scanned, but
# without additional processing.
#ScanHTML yes


##
## Archives
##

# ClamAV can scan within archives and compressed files.
# If you turn off this option, the original files will still be scanned, but
# without unpacking and additional processing.
# Default: yes
#ScanArchive yes

# Mark encrypted archives as viruses (Encrypted.Zip, Encrypted.RAR).
# Default: no
#ArchiveBlockEncrypted no


##
## Limits
##

# The options below protect your system against Denial of Service attacks
# using archive bombs.

# This option sets the maximum amount of data to be scanned for each input file.
# Archives and other containers are recursively extracted and scanned up to this
# value.
# Value of 0 disables the limit
# Note: disabling this limit or setting it too high may result in severe damage
# to the system.
# Default: 100M
#MaxScanSize 150M

# Files larger than this limit won't be scanned. Affects the input file itself
# as well as files contained inside it (when the input file is an archive, a
# document or some other kind of container).
# Value of 0 disables the limit.
# Note: disabling this limit or setting it too high may result in severe damage
# to the system.
# Default: 25M
#MaxFileSize 30M

# Nested archives are scanned recursively, e.g. if a Zip archive contains a RAR
# file, all files within it will also be scanned. This options specifies how
# deeply the process should be continued.
# Note: setting this limit too high may result in severe damage to the system.
# Default: 16
#MaxRecursion 10

# Number of files to be scanned within an archive, a document, or any other
# container file.
# Value of 0 disables the limit.
# Note: disabling this limit or setting it too high may result in severe damage
# to the system.
# Default: 10000
#MaxFiles 15000

# Maximum size of a file to check for embedded PE. Files larger than this value
# will skip the additional analysis step.
# Note: disabling this limit or setting it too high may result in severe damage
# to the system.
# Default: 10M
#MaxEmbeddedPE 10M

# Maximum size of a HTML file to normalize. HTML files larger than this value
# will not be normalized or scanned.
# Note: disabling this limit or setting it too high may result in severe damage
# to the system.
# Default: 10M
#MaxHTMLNormalize 10M

# Maximum size of a normalized HTML file to scan. HTML files larger than this
# value after normalization will not be scanned.
# Note: disabling this limit or setting it too high may result in severe damage
# to the system.
# Default: 2M
#MaxHTMLNoTags 2M

# Maximum size of a script file to normalize. Script content larger than this
# value will not be normalized or scanned.
# Note: disabling this limit or setting it too high may result in severe damage
# to the system.
# Default: 5M
#MaxScriptNormalize 5M

# Maximum size of a ZIP file to reanalyze type recognition. ZIP files larger
# than this value will skip the step to potentially reanalyze as PE.
# Note: disabling this limit or setting it too high may result in severe damage
# to the system.
# Default: 1M
#MaxZipTypeRcg 1M

# This option sets the maximum number of partitions of a raw disk image to be scanned.
# Raw disk images with more partitions than this value will have up to the value number
# partitions scanned. Negative values are not allowed.
# Note: setting this limit too high may result in severe damage or impact performance.
# Default: 50
#MaxPartitions 128

# This option sets the maximum number of icons within a PE to be scanned.
# PE files with more icons than this value will have up to the value number icons scanned.
# Negative values are not allowed.
# WARNING: setting this limit too high may result in severe damage or impact performance.
# Default: 100
#MaxIconsPE 200

# This option sets the maximum recursive calls for HWP3 parsing during scanning.
# HWP3 files using more than this limit will be terminated and alert the user.
# Scans will be unable to scan any HWP3 attachments if the recursive limit is reached.
# Negative values are not allowed.
# WARNING: setting this limit too high may result in severe damage or impact performance.
# Default: 16
#MaxRecHWP3 16

# This option sets the maximum calls to the PCRE match function during an instance of regex matching.
# Instances using more than this limit will be terminated and alert the user but the scan will continue.
# For more information on match_limit, see the PCRE documentation.
# Negative values are not allowed.
# WARNING: setting this limit too high may severely impact performance.
# Default: 10000
#PCREMatchLimit 20000

# This option sets the maximum recursive calls to the PCRE match function during an instance of regex matching.
# Instances using more than this limit will be terminated and alert the user but the scan will continue.
# For more information on match_limit_recursion, see the PCRE documentation.
# Negative values are not allowed and values > PCREMatchLimit are superfluous.
# WARNING: setting this limit too high may severely impact performance.
# Default: 5000
#PCRERecMatchLimit 10000

# This option sets the maximum filesize for which PCRE subsigs will be executed.
# Files exceeding this limit will not have PCRE subsigs executed unless a subsig is encompassed to a smaller buffer.
# Negative values are not allowed.
# Setting this value to zero disables the limit.
# WARNING: setting this limit too high or disabling it may severely impact performance.
# Default: 25M
#PCREMaxFileSize 100M


##
## On-access Scan Settings
##

# Enable on-access scanning. Currently, this is supported via fanotify.
# Clamuko/Dazuko support has been deprecated.
# Default: no
#ScanOnAccess yes

# Set the  mount point to be scanned. The mount point specified, or the mount point 
# containing the specified directory will be watched. If any directories are specified, 
# this option will preempt the DDD system. This will notify only. It can be used multiple times.
# (On-access scan only)
# Default: disabled
#OnAccessMountPath /
#OnAccessMountPath /home/user

# Don't scan files larger than OnAccessMaxFileSize
# Value of 0 disables the limit.
# Default: 5M
#OnAccessMaxFileSize 10M

# Set the include paths (all files inside them will be scanned). You can have
# multiple OnAccessIncludePath directives but each directory must be added
# in a separate line. (On-access scan only)
# Default: disabled
#OnAccessIncludePath /home
#OnAccessIncludePath /students

# Set the exclude paths. All subdirectories are also excluded.
# (On-access scan only)
# Default: disabled
#OnAccessExcludePath /home/bofh

# With this option you can whitelist specific UIDs. Processes with these UIDs
# will be able to access all files.
# This option can be used multiple times (one per line).
# Default: disabled
#OnAccessExcludeUID 0

# Toggles dynamic directory determination. Allows for recursively watching include paths.
# (On-access scan only)
# Default: no
#OnAccessDisableDDD yes

# Modifies fanotify blocking behaviour when handling permission events.
# If off, fanotify will only notify if the file scanned is a virus,
# and not perform any blocking.
# (On-access scan only)
# Default: no
#OnAccessPrevention yes

# Toggles extra scanning and notifications when a file or directory is created or moved.
# Requires the  DDD system to kick-off extra scans.
# (On-access scan only)
# Default: no
#OnAccessExtraScanning yes

##
## Bytecode
##

# With this option enabled ClamAV will load bytecode from the database. 
# It is highly recommended you keep this option on, otherwise you'll miss detections for many new viruses.
# Default: yes
#Bytecode yes

# Set bytecode security level.
# Possible values:
#       None - no security at all, meant for debugging. DO NOT USE THIS ON PRODUCTION SYSTEMS
#         This value is only available if clamav was built with --enable-debug!
#       TrustSigned - trust bytecode loaded from signed .c[lv]d files,
#                insert runtime safety checks for bytecode loaded from other sources
#       Paranoid - don't trust any bytecode, insert runtime checks for all
# Recommended: TrustSigned, because bytecode in .cvd files already has these checks
# Note that by default only signed bytecode is loaded, currently you can only
# load unsigned bytecode in --enable-debug mode.
#
# Default: TrustSigned
#BytecodeSecurity TrustSigned

# Set bytecode timeout in miliseconds.
# 
# Default: 5000
# BytecodeTimeout 1000

##
## Statistics gathering and submitting
##

# Enable statistical reporting.
# Default: no
#StatsEnabled yes

# Disable submission of individual PE sections for files flagged as malware.
# Default: no
#StatsPEDisabled yes

# HostID in the form of an UUID to use when submitting statistical information.
# Default: auto
#StatsHostID auto

# Time in seconds to wait for the stats server to come back with a response
# Default: 10
#StatsTimeout 10
EOF
freshclam
