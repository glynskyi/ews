// ---------------------------------------------------------------------------
// <copyright file="ComputedInsightValuePropertyCollection.cs" company="Microsoft">
//     Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
// ---------------------------------------------------------------------------

//-----------------------------------------------------------------------
// <summary>Implements the class for computed insight value property collection.</summary>
//-----------------------------------------------------------------------




    /// <summary>
    /// Represents a collection of computed insight values.
    /// </summary>
 class ComputedInsightValuePropertyCollection extends ComplexPropertyCollection<ComputedInsightValueProperty>
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="ComputedInsightValuePropertyCollection"/> class.
        /// </summary>
        ComputedInsightValuePropertyCollection()
            : super()
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="ComputedInsightValuePropertyCollection"/> class.
        /// </summary>
        /// <param name="collection">The collection of objects to include.</param>
        ComputedInsightValuePropertyCollection(Iterable<ComputedInsightValueProperty> collection)
        {
            if (collection != null)
            {
                collection.ForEach(this.InternalAdd);
            }
        }

        /// <summary>
        /// Creates the complex property.
        /// </summary>
        /// <param name="xmlElementName">Name of the XML element.</param>
        /// <returns>ComputedInsightValueProperty.</returns>
@override
        ComputedInsightValueProperty CreateComplexProperty(String xmlElementName)
        {
            return new ComputedInsightValueProperty();
        }

        /// <summary>
        /// Gets the name of the collection item XML element.
        /// </summary>
        /// <param name="complexProperty">The complex property.</param>
        /// <returns>XML element name.</returns>
@override
        String GetCollectionItemXmlElementName(ComputedInsightValueProperty complexProperty)
        {
            return XmlElementNames.Property;
        }
    }

