// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go sigs.k8s.io/kustomize/api/types

package types

// GeneratorArgs contains arguments common to ConfigMap and Secret generators.
#GeneratorArgs: {
	// Namespace for the configmap, optional
	namespace?: string @go(Namespace)

	// Name - actually the partial name - of the generated resource.
	// The full name ends up being something like
	// NamePrefix + this.Name + hash(content of generated resource).
	name?: string @go(Name)

	// Behavior of generated resource, must be one of:
	//   'create': create a new one
	//   'replace': replace the existing one
	//   'merge': merge with the existing one
	behavior?: string @go(Behavior)

	#KvPairSources

	// Local overrides to global generatorOptions field.
	options?: null | #GeneratorOptions @go(Options,*GeneratorOptions)
}