// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go crypto/tls

package tls

// a keyAgreement implements the client and server side of a TLS key agreement
// protocol by generating and processing key exchange messages.
_#keyAgreement: _

// rsaKeyAgreement implements the standard TLS key agreement where the client
// encrypts the pre-master secret to the server's public key.
_#rsaKeyAgreement: {
}
