// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go sigs.k8s.io/kustomize/api/types

package types

// GenerationBehavior specifies generation behavior of configmaps, secrets and maybe other resources.
#GenerationBehavior: int // #enumGenerationBehavior

#enumGenerationBehavior:
	#BehaviorUnspecified |
	#BehaviorCreate |
	#BehaviorReplace |
	#BehaviorMerge

#values_GenerationBehavior: {
	BehaviorUnspecified: #BehaviorUnspecified
	BehaviorCreate:      #BehaviorCreate
	BehaviorReplace:     #BehaviorReplace
	BehaviorMerge:       #BehaviorMerge
}

// BehaviorUnspecified is an Unspecified behavior; typically treated as a Create.
#BehaviorUnspecified: #GenerationBehavior & 0

// BehaviorCreate makes a new resource.
#BehaviorCreate: #GenerationBehavior & 1

// BehaviorReplace replaces a resource.
#BehaviorReplace: #GenerationBehavior & 2

// BehaviorMerge attempts to merge a new resource with an existing resource.
#BehaviorMerge: #GenerationBehavior & 3
