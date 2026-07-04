" Vim syntax file
" Language:    Godot Dialogue Manager (.dialogue)
" Maintainer:  botamotch
" Reference:   addons/dialogue_manager compiler grammar
"
" Line types (after leading indentation and an optional `%weight [if ...]`
" prefix are stripped): import, using, comment, title, condition, mutation,
" goto, response, random, dialogue.

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case match
syn sync minlines=1 maxlines=1

" Indentation in .dialogue is done with tabs.
setlocal iskeyword+=_

" ---------------------------------------------------------------------------
" Expression tokens (used inside conditions, mutations, {{ }}, [if]/[do]/[set])
" ---------------------------------------------------------------------------
syn match   dialogueNumber    "\<-\=\d\+\%(\.\d\+\)\=\>"                        contained
syn keyword dialogueBool      true false null                                  contained
syn match   dialogueOperator  "==\|!=\|<=\|>=\|[-+*/%<>=]\|&&\|||\|?\.\|[.,]"   contained
syn match   dialogueKeywordOp "\<\%(and\|or\|not\|in\)\>"                       contained
syn match   dialogueFunction  "\<[A-Za-z_]\w*\ze("                              contained
syn region  dialogueString    start=+&\="+ skip=+\\"+ end=+"+     oneline contained
syn region  dialogueString    start=+&\='+ skip=+\\'+ end=+'+     oneline contained

syn cluster dialogueExpr contains=dialogueNumber,dialogueBool,dialogueOperator,dialogueKeywordOp,dialogueFunction,dialogueString

" ---------------------------------------------------------------------------
" Inline elements (contained inside dialogue / response text)
" ---------------------------------------------------------------------------

" Interpolation: {{ some.expression }}
syn region  dialogueReplacement matchgroup=dialogueMarker
      \ start="{{" end="}}" oneline contained contains=@dialogueExpr

" BBCode: [b], [/b], [color=red], [wave amp=50], etc.
" Defined as the generic `[...]` fallback; the specific bracket regions below
" are defined afterwards so they win at their own start positions.
syn region  dialogueBBCode matchgroup=dialogueMarker
      \ start="\[" end="\]" oneline contained

" Inline random: [[Hi|Hello|Howdy]]
syn region  dialogueInlineRandom matchgroup=dialogueMarker
      \ start="\[\[" end="\]\]" oneline contained contains=dialoguePipe
syn match   dialoguePipe "|" contained

" Tags: [#tag, another]
syn region  dialogueTag matchgroup=dialogueMarker
      \ start="\[#" end="\]" oneline contained

" Static line id: [ID:some_key]
syn region  dialogueLineID matchgroup=dialogueMarker
      \ start="\[ID:" end="\]" oneline contained

" Inline mutation: [do ...], [do! ...], [set ...], [$> ...], [$>> ...]
syn region  dialogueInlineMutation matchgroup=dialogueMarker
      \ start="\[\%(do!\=\|set\|\$>>\=\)\>" end="\]"
      \ oneline contained contains=dialogueInlineMutationKw,@dialogueExpr
syn match   dialogueInlineMutationKw "\%(do!\=\|set\|\$>>\=\)" contained

" Inline conditionals: [if ...] ... [/if], [else]
syn region  dialogueInlineIf matchgroup=dialogueMarker
      \ start="\[if\>" end="\]"
      \ oneline contained contains=dialogueInlineIfKw,@dialogueExpr
syn match   dialogueInlineIfKw "if" contained
syn region  dialogueInlineIfClose matchgroup=dialogueMarker
      \ start="\[\%(else\|/if\)" end="\]" oneline contained

" Inline jump inside a line: => title  or  =>< title
syn match   dialogueJump "=><\=\s\+\%(END!\=\|[A-Za-z_0-9/.{} ]\+\)"
      \ contained contains=dialogueJumpArrow,dialogueJumpEnd
syn match   dialogueJumpArrow "=><\=" contained
syn keyword dialogueJumpEnd END contained
syn match   dialogueJumpEnd "END!" contained

syn cluster dialogueInline contains=dialogueReplacement,dialogueInlineRandom,dialogueTag,dialogueLineID,dialogueInlineMutation,dialogueInlineIf,dialogueInlineIfClose,dialogueBBCode,dialogueJump

" ---------------------------------------------------------------------------
" Line types (defined as regions so each line's contents are scoped)
" ---------------------------------------------------------------------------

" Dialogue is the fallback line; defined FIRST so more specific line regions
" (defined below) win at column 0 on their own lines.
syn region  dialogueLine matchgroup=NONE start="^\ze\s*\S" end="$"
      \ keepend oneline
      \ contains=dialogueCharacter,dialogueRandomPrefix,@dialogueInline
syn match   dialogueCharacter "\%(^\s*\%(%\S*\s\+\)\=\)\@<=[^:\[]\{-}\ze:\%(\s\|$\)" contained
" Weighted-random sibling prefix: %  or  %0.5  or  % [if condition]
syn match   dialogueRandomPrefix "^\s*%\%([0-9.]\+\)\=\%(\s\+\[if\>[^\]]*\]\)\=" contained contains=dialogueInlineIf

" Comments
syn region  dialogueComment start="^\s*#" end="$" oneline keepend contains=@Spell

" Titles: ~ some_title
syn region  dialogueTitle matchgroup=dialogueTitleMarker
      \ start="^\s*\~\s*" end="$" oneline keepend

" import "res://..." as Prefix
syn region  dialogueImport start="^\s*import\>" end="$" oneline keepend
      \ contains=dialogueImportKw,dialogueString
syn keyword dialogueImportKw import as contained

" using SomeState
syn region  dialogueUsing start="^\s*using\>" end="$" oneline keepend
      \ contains=dialogueUsingKw
syn keyword dialogueUsingKw using contained

" Conditions: if / elif / else / else if / while / match / when
syn region  dialogueCondition start="^\s*\%(if\|elif\|else\|while\|match\|when\)\>" end="$"
      \ oneline keepend contains=dialogueConditionKw,dialogueMatchColon,@dialogueExpr
syn keyword dialogueConditionKw if elif else while match when contained
syn match   dialogueMatchColon ":\s*$" contained

" Mutations: do / do! / set / $> / $>>
syn region  dialogueMutation start="^\s*\%(do!\=\|set\|\$>>\=\)\s" end="$"
      \ oneline keepend contains=dialogueMutationKw,@dialogueExpr
syn match   dialogueMutationKw "^\s*\zs\%(do!\=\|set\|\$>>\=\)" contained

" Goto line: => title  or  =>< title
syn region  dialogueGoto start="^\s*=><\=\s" end="$"
      \ oneline keepend contains=dialogueJump

" Response: - Some choice
syn region  dialogueResponse matchgroup=dialogueResponseMarker
      \ start="^\s*-\s" end="$"
      \ oneline keepend contains=@dialogueInline

" ---------------------------------------------------------------------------
" Highlight links
" ---------------------------------------------------------------------------
hi def link dialogueComment            Comment
hi def link dialogueTitle              Function
hi def link dialogueTitleMarker        Special
hi def link dialogueCharacter          Type
hi def link dialogueImport             Include
hi def link dialogueImportKw           Include
hi def link dialogueUsing              PreProc
hi def link dialogueUsingKw            PreProc
hi def link dialogueCondition          Normal
hi def link dialogueConditionKw        Conditional
hi def link dialogueMatchColon         Delimiter
hi def link dialogueMutation           Normal
hi def link dialogueMutationKw         Statement
hi def link dialogueGoto               Normal
hi def link dialogueJump               Label
hi def link dialogueJumpArrow          Operator
hi def link dialogueJumpEnd            Special
hi def link dialogueResponseMarker     Special
hi def link dialogueRandomPrefix       Special

hi def link dialogueMarker             Delimiter
hi def link dialoguePipe               Special
hi def link dialogueReplacement        Normal
hi def link dialogueTag                PreProc
hi def link dialogueLineID             SpecialComment
hi def link dialogueBBCode             Tag
hi def link dialogueInlineMutationKw   Statement
hi def link dialogueInlineIfKw         Conditional
hi def link dialogueInlineIf           Normal

hi def link dialogueString             String
hi def link dialogueNumber             Number
hi def link dialogueBool               Boolean
hi def link dialogueOperator           Operator
hi def link dialogueKeywordOp          Keyword
hi def link dialogueFunction           Function

let b:current_syntax = "dialogue"

let &cpo = s:cpo_save
unlet s:cpo_save
