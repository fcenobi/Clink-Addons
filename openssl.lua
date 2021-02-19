--[[

What is this?
This is a definition file for command completion in Clink.

How to use this file?
- Run 'clink info'
- Place the file in one of the script locations
- Restart clink
- Now you should have tab completion for openssl parameters

Where do I get the latest version?
https://github.com/dodmi/Clink/tree/master/

When was this file updated?
2021-02-19

]]--

local parser = clink.arg.new_parser
local openssl_parser = parser({
    "asn1parse" .. parser({}, -- empty {}: don't suggest any positional args
        "-help", "-i", "-noout", "-dump", "-strictpem",
		"-offset",		-- Parameter +int file offset
		"-length",		-- Parameter +int length of section
		"-dlimit",		-- Parameter dump +int the first unknown bytes
		"-strparse", 	-- Parameter +int string offset
		"-genstr", 		-- Parameter string to generate ASN1 structure from
		"-item", 		-- Parameter string, item to parse
		"-inform" .. parser({"PEM", "DER"}),
	    "-in" .. parser({clink.filematches}),  		-- Parameter input file
		"-out" .. parser({clink.filematches}), 		-- Parameter output file
		"-oid" .. parser({clink.filematches}), 		-- Parameter additional oid definitions file
		"-genconf" .. parser({clink.filematches}) 	-- Parameter file to generate ASN1 structure from
	),
	"ca" .. parser({}, -- empty {}: don't suggest any positional args
		"-help", "-verbose", "-utf8", "-create_serial", "-rand_serial",
		"-multivalue-rdn", "-selfsign", "-notext", "-batch", "-preserveDN",
		"-noemailDN", "-gencrl", "-msie_hack", "-infiles", "-updatedb",
		"-name", 				-- Parameter The particular CA definition to use
		"-subj", 				-- Parameter Use arg instead of request's subject
		"-startdate", 			-- Parameter Cert notBefore, YYMMDDHHMMSSZ
		"-enddate", 			-- Parameter YYMMDDHHMMSSZ cert notAfter (overrides -days)
		"-days", 				-- Parameter Number of days to certify the cert for
		"-policy", 				-- Parameter The CA 'policy' to support
		"-key", 				-- Parameter Key to decode the private key if it is encrypted
		"-sigopt", 				-- Parameter Signature parameter in n:v form
		"-crldays",				-- Parameter Days until the next CRL is due
		"-crlhours", 			-- Parameter Hours until the next CRL is due
		"-crlsec", 				-- Parameter Seconds until the next CRL is due
		"-valid", 				-- Parameter Add a Valid(not-revoked) DB entry about a cert (given in file)
		"-extensions",			-- Parameter Extension section (override value in config file)
		"-status", 				-- Parameter Shows cert status given the serial number
		"-crlexts", 			-- Parameter CRL extension section (override value in config file)
		"-crl_reason", 			-- Parameter revocation reason
		"-crl_hold", 			-- Parameter the hold instruction, an OID. Sets revocation reason to certificateHold
		"-crl_compromise", 		-- Parameter sets compromise time to val and the revocation reason to keyCompromise
		"-crl_CA_compromise",	-- Parameter sets compromise time to val and the revocation reason to CACompromise
		"-engine",				-- Parameter Use engine, possibly a hardware device
		"-passin",				-- Parameter Input file pass phrase source
 		"-md" .. parser({"md2", "md5", "sha", "sha1"}),
 		"-keyform" .. parser({"PEM", "ENGINE"}),
		"-config" .. parser({clink.filematches}),		-- Parameter config file
		"-keyfile" .. parser({clink.filematches}),		-- Parameter Private key
		"-cert" .. parser({clink.filematches}), 		-- Parameter The CA cert
		"-in" .. parser({clink.filematches}), 			-- Parameter The input PEM encoded cert request(s)
		"-out" .. parser({clink.filematches}), 			-- Parameter Where to put the output file(s)
		"-ss_cert" .. parser({clink.filematches}), 		-- Parameter File contains a self signed cert to sign
		"-spkac" .. parser({clink.filematches}), 		-- Parameter File contains DN and signed public key and challenge
		"-revoke" .. parser({clink.filematches}), 		-- Parameter Revoke a cert (given in file)
		"-extfile" .. parser({clink.filematches}), 		-- Parameter Configuration file with X509v3 extensions to add
		"-rand" .. parser({clink.filematches}), 		-- Parameter Load the file(s) into the random number generator
		"-writerand" .. parser({clink.filematches}), 	-- Parameter Write random data to the specified file
		"-outdir" .. parser({clink.dirmatches}) 		-- Parameter Where to put output cert
	),
	"ciphers" .. parser({}, -- empty {}: don't suggest any positional args
		"-help", "-v", "-V", "-s", "-tls1", "-tls1_1", "-tls1_2",
		"-tls1_3", "-stdname", "-psk", "-srp",
		"-convert", 		-- Parameter Convert standard name into OpenSSL name
		"-ciphersuites" 	-- Parameter Configure the TLSv1.3 ciphersuites to use
	),
	"cms" .. parser(parser({clink.filematches}),
		"-help", "-encrypt", "-decrypt", "-sign", "-sign_receipt",
		"-resign", "-verify", "-verify_retcode", "-cmsout",
		"-data_out", "-data_create", "-digest_verify", "-digest_create",
		"-compress", "-uncompress", "-EncryptedData_decrypt",
		"-EncryptedData_encrypt", "-debug_decrypt", "-text",
		"-asciicrlf", "-nointern", "-noverify", "-nocerts", "-noattr",
		"-nodetach", "-nosmimecap", "-binary", "-keyid", "-nosigs",
		"-no_content_verify", "-no_attr_verify", "-stream", "-indef",
		"-noindef", "-crlfeol", "-noout", "-receipt_request_print",
		"-receipt_request_all", "-receipt_request_first", "-no-CAfile",
		"-no-CApath", "-print", "-*", "-ignore_critical", "-issuer_checks",
		"-crl_check", "-crl_check_all", "-policy_check", "-explicit_policy",
		"-inhibit_any", "-inhibit_map", "-x509_strict", "-extended_crl",
		"-use_deltas", "-policy_print", "-check_ss_sig", "-trusted_first",
		"-suiteB_128_only", "-suiteB_128", "-suiteB_192", "-partial_chain",
		"-no_alt_chains", "-no_check_time", "-allow_proxy_certs",
		"-aes128-wrap", "-aes192-wrap", "-aes256-wrap", "-des3-wrap",
		"-secretkey",				-- Parameter val
		"-secretkeyid",				-- Parameter val
		"-pwri_password",			-- Parameter val
		"-econtent_type",			-- Parameter val
		"-to",						-- Parameter To address
		"-from",					-- Parameter From address
		"-subject",					-- Parameter Subject
		"-signer",					-- Parameter Signer certificate file
		"-md",						-- Parameter Digest algorithm to use when signing or resigning
		"-keyopt",					-- Parameter Set public key parameters as n:v pairs
		"-receipt_request_from",	-- Parameter val
		"-receipt_request_to",		-- Parameter val
		"-policy",					-- Parameter adds policy to the acceptable policy set
		"-purpose",					-- Parameter certificate chain purpose
		"-verify_name",				-- Parameter verification policy name
		"-verify_depth",			-- Parameter chain depth limit
		"-auth_level",				-- Parameter chain authentication security level
		"-attime",					-- Parameter verification epoch time
		"-verify_hostname",			-- Parameter expected peer hostname
		"-verify_email",			-- Parameter expected peer email
		"-verify_ip",				-- Parameter expected peer IP address
		"-engine",					-- Parameter Use engine e, possibly a hardware device
		"-passin", 					-- Parameter Input file pass phrase source
		"-inform" .. parser({"SMIME", "PEM", "DER"}),
		"-outform" .. parser({"SMIME", "PEM", "DER"}),
		"-rctform" .. parser({"PEM", "DER"}),
		"-keyform" .. parser({"PEM", "ENGINE"}),
		"-in infile" .. parser({clink.filematches}), 		-- Parameter Input file
		"-out" .. parser{clink.filematches}, 				-- Parameter Output file
		"-verify_receipt" .. parser{clink.filematches}, 	-- Parameter infile
		"-certfile" .. parser{clink.filematches}, 			-- Parameter Other certificates file
		"-CAfile" .. parser{clink.filematches}, 			-- Parameter Trusted certificates file
		"-recip" .. parser{clink.filematches}, 				-- Parameter Recipient cert file for decryption
		"-certsout" .. parser{clink.filematches}, 			-- Parameter Certificate output file
		"-inkey" .. parser{clink.filematches}, 				-- Parameter Input private key (if not signer or recipient)
		"-rand" .. parser{clink.filematches}, 				-- Parameter Load the file(s) into the random number generator
		"-writerand" .. parser{clink.filematches}, 			-- Parameter Write random data to the specified file
		"-content" .. parser{clink.filematches}, 			-- Parameter Supply or override content for detached signature
		"-CApath" .. parser{clink.dirmatches} 				-- Parameter trusted certificates directory
	),
	"crl" .. parser({}, -- empty {}: don't suggest any positional args
		"-help", "-issuer", "-lastupdate", "-nextupdate", "-noout",
		"-fingerprint", "-crlnumber", "-badsig", "-no-CAfile",
		"-no-CApath", "-verify", "-text", "-hash", "-*", "-hash_old",
		"-nameopt",			-- Parameter Various certificate name options
		"-inform" .. parser({"PEM", "DER"}),
		"-outform" .. parser({"PEM", "DER"}),
		"-keyform" .. parser({"PEM", "ENGINE"}),
		"-in" .. parser{clink.filematches}, 		-- Parameter Input file - default stdin
		"-out" .. parser{clink.filematches}, 		-- Parameter output file - default stdout
		"-key" .. parser{clink.filematches}, 		-- Parameter CRL signing Private key to use
		"-gendelta" .. parser{clink.filematches}, 	-- Parameter Other CRL to compare/diff to the Input one
		"-CAfile" .. parser{clink.filematches}, 	-- Parameter Verify CRL using certificates in file name
		"-CApath" .. parser{clink.dirmatches}	 	-- Parameter Verify CRL using certificates in dir
	),
	"crl2pkcs7" .. parser({}, -- empty {}: don't suggest any positional args
		"-help", "-nocrl",
		"-inform" .. parser({"PEM", "DER"}),
		"-outform" .. parser({"PEM", "DER"}),
		"-in" .. parser{clink.filematches}, 		-- Parameter Input file
		"-out" .. parser{clink.filematches}, 		-- Parameter Output file
		"-certfile" .. parser{clink.filematches}	-- Parameter File of chain of certs to a trusted CA
	),
	"dgst" .. parser(
		parser{clink.filematches},
		"-help", "-list", "-c", " -r", "-hex", "-binary", "-d",
		"-debug", "-fips-fingerprint", "-*", "-engine_impl",
		"-hmac",		-- Parameter Create hashed MAC with key
		"-mac",			-- Parameter Create MAC (not necessarily HMAC)
		"-sigopt",		-- Parameter Signature parameter in n:v form
		"-macopt",		-- Parameter MAC algorithm parameters in n:v form or key
		"-engine",		-- Parameter Use engine e, possibly a hardware device
		"-passin", 		-- Parameter Input file pass phrase source
		"-signature", 	-- Parameter File with signature to verify
		"-keyform" .. parser({"PEM", "ENGINE"}),
		"-out" .. parser{clink.filematches}, 		-- Parameter Output to filename rather than stdout
		"-rand" .. parser{clink.filematches}, 		-- Parameter Load the file(s) into the random number generator
		"-writerand" .. parser{clink.filematches}, 	-- Parameter Write random data to the specified file
		"-sign" .. parser{clink.filematches}, 		-- Parameter Sign digest using private key
		"-verify" .. parser{clink.filematches}, 	-- Parameter Verify a signature using public key
		"-prverify" .. parser{clink.filematches} 	-- Parameter Verify a signature using private key
	),
	"dhparam" .. parser({}, -- empty {}: don't suggest any positional args
		"-help", "-check", "-text", "-noout", "-C", "-2", "-5", "-dsaparam",
		"-engine",		-- Parameter Use engine e, possibly a hardware device
		"-inform" .. parser({"PEM", "DER"}),
 		"-outform" .. parser({"PEM", "DER"}),
		"-in" .. parser{clink.filematches}, 		-- Parameter Input file
		"-out" .. parser{clink.filematches}, 		-- Parameter Output file
		"-rand" .. parser{clink.filematches}, 		-- Parameter Load the file(s) into the random number generator
		"-writerand" .. parser{clink.filematches} 	-- Parameter Write random data to the specified file
	),
	"dsa" .. parser({}, -- empty {}: don't suggest any positional args
		"-help", "-noout", "-text", "-modulus", "-pubin", "-pubout",
		"-*", "-pvk-strong", "-pvk-weak", "-pvk-none",
		"-inform" .. parser({"PEM", "DER", "PVK"}),
		"-outform" .. parser({"PEM", "DER", "PVK"}),
		"-engine",	-- Parameter Use engine e, possibly a hardware device
		"-passout",	-- Parameter Output file pass phrase source
		"-passin", 	-- Parameter Input file pass phrase source
		"-in" .. parser{clink.filematches}, 		-- Parameter Input key
		"-out" .. parser{clink.filematches} 		-- Parameter Output file
	),
	"dsaparam" .. parser({}, -- empty {}: don't suggest any positional args
		"-help", "-text", "-C", "-noout", "-genkey",
		"-engine",		-- Parameter Use engine e, possibly a hardware device
		"-inform" .. parser({"PEM", "DER"}),
 		"-outform" .. parser({"PEM", "DER"}),
		"-in" .. parser{clink.filematches}, 		-- Parameter Input file
		"-out" .. parser{clink.filematches}, 		-- Parameter Output file
		"-rand" .. parser{clink.filematches}, 		-- Parameter Load the file(s) into the random number generator
		"-writerand" .. parser{clink.filematches} 	-- Parameter Write random data to the specified file
	),
	"ec" .. parser({}, -- empty {}: don't suggest any positional args
		"-help", "-noout", "-text", "-param_out", "-pubin",
		"-pubout", "-no_public", "-check", "-*",
		"-param_enc",	-- Parameter Specifies the way the ec parameters are encoded
		"-conv_form",	-- Parameter Specifies the point conversion form
		"-engine",		-- Parameter Use engine, possibly a hardware device
		"-passout", 	-- Parameter Output file pass phrase source
		"-passin", 		-- Parameter Input file pass phrase source
		"-inform" .. parser({"PEM", "DER"}),
 		"-outform" .. parser({"PEM", "DER"}),
		"-in" .. parser{clink.filematches}, 		-- Parameter Input file
		"-out" .. parser{clink.filematches} 		-- Parameter Output file
	),
	"ecparam" .. parser({}, -- empty {}: don't suggest any positional args
		"-help", "-text", "-C", "-check", "-list_curves",
		"-no_seed", "-noout", "-genkey",
		"-name",		-- Parameter Use the ec parameters with specified 'short name'
		"-conv_form",	-- Parameter Specifies the point conversion form
		"-param_enc",	-- Parameter Specifies the way the ec parameters are encoded
		"-engine",		-- Parameter Use engine, possibly a hardware device
		"-inform" .. parser({"PEM", "DER"}),
 		"-outform" .. parser({"PEM", "DER"}),
		"-in" .. parser{clink.filematches}, 		-- Parameter Input file  - default stdin
		"-out" .. parser{clink.filematches}, 		-- Parameter Output file - default stdout
		"-rand" .. parser{clink.filematches}, 		-- Parameter Load the file(s) into the random number generator
		"-writerand" .. parser{clink.filematches} 	-- Parameter Write random data to the specified file
	),
	"enc" .. parser({}, -- empty {}: don't suggest any positional args
		"-help","-list", "-ciphers", "-e", "-d", "-p", "-P", "-v", "-nopad",
		"-salt", "-nosalt", "-debug", "-a", "-base64", "-A", "-pbkdf2", "-none", "-*",
		"-pass",	-- Parameter Passphrase source
		"-bufsize",	-- Parameter Buffer size
		"-k",		-- Parameter Passphrase
		"-K",		-- Parameter Raw key, in hex
		"-S",		-- Parameter Salt, in hex
		"-iv",		-- Parameter IV in hex
		"-md",		-- Parameter Use specified digest to create a key from the passphrase
		"-iter", 	-- Parameter Specify the iteration count and force use of PBKDF2
		"-engine",	-- Parameter Use engine, possibly a hardware device
		"-in" .. parser{clink.filematches}, 		-- Parameter Input file
		"-out" .. parser{clink.filematches}, 		-- Parameter Output file
		"-kfile" .. parser{clink.filematches}, 		-- Parameter Read passphrase from file
		"-rand" .. parser{clink.filematches}, 		-- Parameter Load the file(s) into the random number generator
		"-writerand" .. parser{clink.filematches} 	-- Parameter Write random data to the specified file
	),
	"engine" .. parser({}, -- empty {}: don't suggest any positional args
		"-help", "-v", "-vv", "-vvv", "-vvvv", "-c", "-t", "-tt",
		"-pre",		-- Parameter Run command against the ENGINE before loading it
		"-post"	-- Parameter Run command against the ENGINE after loading it
	),
	"errstr" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
	),
	"gendsa" .. parser(
		parser{clink.filematches},
		"-help", "-*",
		"-engine",	-- Parameter Use engine, possibly a hardware device
		"-passout", -- Parameter Output file pass phrase source
		"-out" .. parser{clink.filematches}, 		-- Parameter Output the key to the specified file
		"-rand" .. parser{clink.filematches}, 		-- Parameter Load the file(s) into the random number generator
		"-writerand" .. parser{clink.filematches} 	-- Parameter Write random data to the specified file
	),
	"genpkey" .. parser({}, -- empty {}: don't suggest any positional args
		"-help", "-genparam", "-text", "-*",
		"-algorithm",	-- Parameter The public key algorithm
		"-pkeyopt",		-- Parameter Set the public key algorithm option as opt:value
		"-engine",		-- Parameter Use engine, possibly a hardware device
		"-pass", 		-- Parameter Output file pass phrase source
		"-outform" .. parser({"PEM", "DER"}),
		"-out" .. parser{clink.filematches}, 		-- Parameter Output file
		"-paramfile" .. parser{clink.filematches} 	-- Parameter Parameters file
	),
	"genrsa" .. parser({}, -- empty {}: don't suggest any positional args
		"-help", "-3", "-F4", "-f4", "-*",
		"-passout",	-- Parameter Output file pass phrase source
		"-engine",	-- Parameter Use engine, possibly a hardware device
		"-primes",	-- Parameter Specify number of primes
 		"-out" .. parser{clink.filematches}, 		-- Parameter Output the key to specified file
 		"-rand" .. parser{clink.filematches}, 		-- Parameter Load the file(s) into the random number generator
 		"-writerand" .. parser{clink.filematches} 	-- Parameter Write random data to the specified file
	),
	"help" .. parser({} -- empty {}: don't suggest any positional args
	),
	"list" .. parser({}, -- empty {}: don't suggest any positional args
		"-help", "-1", "-commands", "-digest-commands", "-digest-algorithms",
		"-cipher-commands", "-cipher-algorithms", "-public-key-algorithms",
		"-public-key-methods", "-disabled", "-missing-help",
		"-options"		-- Parameter List options for specified command
	),
	"nseq" .. parser({}, -- empty {}: don't suggest any positional args
		"-help", "-toseq",
		"-in" .. parser{clink.filematches}, 		-- Parameter Input file
		"-out" .. parser{clink.filematches} 		-- Parameter Output file
	),
	"ocsp" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"passwd" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"pkcs12" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"pkcs7" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"pkcs8" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"pkey" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"pkeyparam" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"pkeyutl" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"prime" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"rand" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"rehash" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"req" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"rsa" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"rsautl" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"s_client" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"s_server" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"s_time" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"sess_id" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"smime" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"speed" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"spkac" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"srp" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"storeutl" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"ts" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"verify" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		),
	"version" .. parser({}, -- empty {}: don't suggest any positional args
		"-help", "-a", "-b", "-d", "-e", "-f", "-o", "-p", "-r", "-v"
	),
	"x509" .. parser({}, -- empty {}: don't suggest any positional args
		"-help"
		)
})

clink.arg.register_parser("openssl", openssl_parser)
