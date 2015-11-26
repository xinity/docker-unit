// Package commands contains the set of Dockerfile commands.
package commands

// List of Dockerfile commands.
const (
	Add         = "ADD"
	After       = "@AFTER"
	AssertTrue  = "ASSERT_TRUE"
	AssertFalse = "ASSERT_FALSE"
	Before      = "@BEFORE"
	Cmd         = "CMD"
	Copy        = "COPY"
	Entrypoint  = "ENTRYPOINT"
	Ephemeral   = "EPHEMERAL"
	Env         = "ENV"
	Expose      = "EXPOSE"
	Extract     = "EXTRACT"
	From        = "FROM"
	Label       = "LABEL"
	Maintainer  = "MAINTAINER"
	Onbuild     = "ONBUILD"
	Run         = "RUN"
	User        = "USER"
	Volume      = "VOLUME"
	Workdir     = "WORKDIR"
)

// Commands is a set of all Dockerfile commands.
var Commands = map[string]struct{}{
	Add:         {},
	After:       {},
	AssertTrue:  {},
	AssertFalse: {},
	Before:      {},
	Cmd:         {},
	Copy:        {},
	Entrypoint:  {},
	Ephemeral:   {},
	Env:         {},
	Expose:      {},
	Extract:     {},
	From:        {},
	Label:       {},
	Maintainer:  {},
	Onbuild:     {},
	Run:         {},
	User:        {},
	Volume:      {},
	Workdir:     {},
}

// FilesystemModifierCommands is a subset of commands that typically modify the
// filesystem of a container and require a commit.
var FilesystemModifierCommands = map[string]struct{}{
	Add:     {},
	Copy:    {},
	Extract: {},
	Run:     {},
}

// ReplaceEnvAllowed is a subset of commands for which environment variable
// interpolation will happen.
var ReplaceEnvAllowed = map[string]struct{}{
	Add:     {},
	Copy:    {},
	Env:     {},
	Expose:  {},
	Extract: {},
	Label:   {},
	User:    {},
	Volume:  {},
	Workdir: {},
}

var TestAssert = map[string]struct{}{
	AssertTrue:  {},
	AssertFalse: {},
}

var NewTestBlock = map[string]struct{}{
	After:  {},
	Before: {},
}
