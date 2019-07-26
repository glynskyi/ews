/*
 * Exchange Web Services Managed API
 *
 * Copyright (c) Microsoft Corporation
 * All rights reserved.
 *
 * MIT License
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
 * to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
 * FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */




    /// <summary>
    /// Persona schema
    /// </summary>
    [Schema]
 class PersonaSchema : ItemSchema
    {
        /// <summary>
        /// FieldURIs for persona.
        /// </summary>
        /* private */ static class FieldUris
        {
 const String PersonaId = "persona:PersonaId";
 const String PersonaType = "persona:PersonaType";
 const String CreationTime = "persona:CreationTime";
 const String DisplayNameFirstLastHeader = "persona:DisplayNameFirstLastHeader";
 const String DisplayNameLastFirstHeader = "persona:DisplayNameLastFirstHeader";
 const String DisplayName = "persona:DisplayName";
 const String DisplayNameFirstLast = "persona:DisplayNameFirstLast";
 const String DisplayNameLastFirst = "persona:DisplayNameLastFirst";
 const String FileAs = "persona:FileAs";
 const String Generation = "persona:Generation";
 const String DisplayNamePrefix = "persona:DisplayNamePrefix";
 const String GivenName = "persona:GivenName";
 const String Surname = "persona:Surname";
 const String Title = "persona:Title";
 const String CompanyName = "persona:CompanyName";
 const String EmailAddress = "persona:EmailAddress";
 const String EmailAddresses = "persona:EmailAddresses";
 const String ImAddress = "persona:ImAddress";
 const String HomeCity = "persona:HomeCity";
 const String WorkCity = "persona:WorkCity";
 const String Alias = "persona:Alias";
 const String RelevanceScore = "persona:RelevanceScore";
 const String Attributions = "persona:Attributions";
 const String OfficeLocations = "persona:OfficeLocations";
 const String ImAddresses = "persona:ImAddresses";
 const String Departments = "persona:Departments";
 const String ThirdPartyPhotoUrls = "persona:ThirdPartyPhotoUrls";
        }

        /// <summary>
        /// Defines the PersonaId property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition PersonaId =
            new ComplexPropertyDefinition<ItemId>(
                XmlElementNames.PersonaId,
                FieldUris.PersonaId,
                PropertyDefinitionFlags.AutoInstantiateOnRead | PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1,
                delegate() { return new ItemId(); });

        /// <summary>
        /// Defines the PersonaType property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition PersonaType =
            new StringPropertyDefinition(
                XmlElementNames.PersonaType,
                FieldUris.PersonaType,
                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1);

        /// <summary>
        /// Defines the CreationTime property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition CreationTime =
            new DateTimePropertyDefinition(
                XmlElementNames.CreationTime,
                FieldUris.CreationTime,
                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1);

        /// <summary>
        /// Defines the DisplayNameFirstLastHeader property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition DisplayNameFirstLastHeader =
            new StringPropertyDefinition(
                XmlElementNames.DisplayNameFirstLastHeader,
                FieldUris.DisplayNameFirstLastHeader,
                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1);

        /// <summary>
        /// Defines the DisplayNameLastFirstHeader property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition DisplayNameLastFirstHeader =
            new StringPropertyDefinition(
                XmlElementNames.DisplayNameLastFirstHeader,
                FieldUris.DisplayNameLastFirstHeader,
                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1);

        /// <summary>
        /// Defines the DisplayName property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition DisplayName =
            new StringPropertyDefinition(
                XmlElementNames.DisplayName,
                FieldUris.DisplayName,
                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1);

        /// <summary>
        /// Defines the DisplayNameFirstLast property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition DisplayNameFirstLast =
            new StringPropertyDefinition(
                XmlElementNames.DisplayNameFirstLast,
                FieldUris.DisplayNameFirstLast,
                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1);

        /// <summary>
        /// Defines the DisplayNameLastFirst property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition DisplayNameLastFirst =
            new StringPropertyDefinition(
                XmlElementNames.DisplayNameLastFirst,
                FieldUris.DisplayNameLastFirst,
                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1);

        /// <summary>
        /// Defines the FileAs property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition FileAs =
            new StringPropertyDefinition(
                XmlElementNames.FileAs,
                FieldUris.FileAs,
                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1);

        /// <summary>
        /// Defines the Generation property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition Generation =
            new StringPropertyDefinition(
                XmlElementNames.Generation,
                FieldUris.Generation,
                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1);

        /// <summary>
        /// Defines the DisplayNamePrefix property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition DisplayNamePrefix =
            new StringPropertyDefinition(
                XmlElementNames.DisplayNamePrefix,
                FieldUris.DisplayNamePrefix,
                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1);

        /// <summary>
        /// Defines the GivenName property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition GivenName =
            new StringPropertyDefinition(
                XmlElementNames.GivenName,
                FieldUris.GivenName,
                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1);

        /// <summary>
        /// Defines the Surname property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition Surname =
            new StringPropertyDefinition(
                XmlElementNames.Surname,
                FieldUris.Surname,
                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1);

        /// <summary>
        /// Defines the Title property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition Title =
            new StringPropertyDefinition(
                XmlElementNames.Title,
                FieldUris.Title,
                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1);

        /// <summary>
        /// Defines the CompanyName property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition CompanyName =
            new StringPropertyDefinition(
                XmlElementNames.CompanyName,
                FieldUris.CompanyName,
                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1);

        /// <summary>
        /// Defines the EmailAddress property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition EmailAddress =
            new ComplexPropertyDefinition<PersonaEmailAddress>(
                XmlElementNames.EmailAddress,
                FieldUris.EmailAddress,
                PropertyDefinitionFlags.AutoInstantiateOnRead | PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1,
                delegate() { return new PersonaEmailAddress(); });

        /// <summary>
        /// Defines the EmailAddresses property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition EmailAddresses =
            new ComplexPropertyDefinition<PersonaEmailAddressCollection>(
                XmlElementNames.EmailAddresses,
                FieldUris.EmailAddresses,
                PropertyDefinitionFlags.AutoInstantiateOnRead | PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1,
                delegate() { return new PersonaEmailAddressCollection(); });

        /// <summary>
        /// Defines the ImAddress property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition ImAddress =
            new StringPropertyDefinition(
                XmlElementNames.ImAddress,
                FieldUris.ImAddress,
                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1);

        /// <summary>
        /// Defines the HomeCity property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition HomeCity =
            new StringPropertyDefinition(
                XmlElementNames.HomeCity,
                FieldUris.HomeCity,
                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1);

        /// <summary>
        /// Defines the WorkCity property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition WorkCity =
            new StringPropertyDefinition(
                XmlElementNames.WorkCity,
                FieldUris.WorkCity,
                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1);

        /// <summary>
        /// Defines the Alias property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition Alias =
            new StringPropertyDefinition(
                XmlElementNames.Alias,
                FieldUris.Alias,
                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1);

        /// <summary>
        /// Defines the RelevanceScore property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition RelevanceScore =
            new IntPropertyDefinition(
                XmlElementNames.RelevanceScore,
                FieldUris.RelevanceScore,
                PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1,
                true);

        /// <summary>
        /// Defines the Attributions property
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition Attributions =
            new ComplexPropertyDefinition<AttributionCollection>(
                XmlElementNames.Attributions,
                FieldUris.Attributions,
                PropertyDefinitionFlags.AutoInstantiateOnRead | PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1,
                delegate() { return new AttributionCollection(); });

        /// <summary>
        /// Defines the OfficeLocations property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition OfficeLocations =
            new ComplexPropertyDefinition<AttributedStringCollection>(
                XmlElementNames.OfficeLocations,
                FieldUris.OfficeLocations,
                PropertyDefinitionFlags.AutoInstantiateOnRead | PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1,
                delegate() { return new AttributedStringCollection(); });

        /// <summary>
        /// Defines the ImAddresses property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition ImAddresses =
            new ComplexPropertyDefinition<AttributedStringCollection>(
                XmlElementNames.ImAddresses,
                FieldUris.ImAddresses,
                PropertyDefinitionFlags.AutoInstantiateOnRead | PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1,
                delegate() { return new AttributedStringCollection(); });

        /// <summary>
        /// Defines the Departments property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition Departments =
            new ComplexPropertyDefinition<AttributedStringCollection>(
                XmlElementNames.Departments,
                FieldUris.Departments,
                PropertyDefinitionFlags.AutoInstantiateOnRead | PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1,
                delegate() { return new AttributedStringCollection(); });

        /// <summary>
        /// Defines the ThirdPartyPhotoUrls property.
        /// </summary>
        [SuppressMessage("Microsoft.Security", "CA2104:DoNotDeclareReadOnlyMutableReferenceTypes", Justification = "Immutable type")]
 static readonly PropertyDefinition ThirdPartyPhotoUrls =
            new ComplexPropertyDefinition<AttributedStringCollection>(
                XmlElementNames.ThirdPartyPhotoUrls,
                FieldUris.ThirdPartyPhotoUrls,
                PropertyDefinitionFlags.AutoInstantiateOnRead | PropertyDefinitionFlags.CanSet | PropertyDefinitionFlags.CanUpdate | PropertyDefinitionFlags.CanDelete | PropertyDefinitionFlags.CanFind,
                ExchangeVersion.Exchange2013_SP1,
                delegate() { return new AttributedStringCollection(); });

        // This must be declared after the property definitions
        static new readonly PersonaSchema Instance = new PersonaSchema();

        /// <summary>
        /// Registers properties.
        /// </summary>
        /// <remarks>
        /// IMPORTANT NOTE: PROPERTIES MUST BE REGISTERED IN SCHEMA ORDER (i.e. the same order as they are defined in types.xsd)
        /// </remarks>
@override
        void RegisterProperties()
        {
            super.RegisterProperties();

            this.RegisterProperty(PersonaId);
            this.RegisterProperty(PersonaType);
            this.RegisterProperty(CreationTime);
            this.RegisterProperty(DisplayNameFirstLastHeader);
            this.RegisterProperty(DisplayNameLastFirstHeader);
            this.RegisterProperty(DisplayName);
            this.RegisterProperty(DisplayNameFirstLast);
            this.RegisterProperty(DisplayNameLastFirst);
            this.RegisterProperty(FileAs);
            this.RegisterProperty(Generation);
            this.RegisterProperty(DisplayNamePrefix);
            this.RegisterProperty(GivenName);
            this.RegisterProperty(Surname);
            this.RegisterProperty(Title);
            this.RegisterProperty(CompanyName);
            this.RegisterProperty(EmailAddress);
            this.RegisterProperty(EmailAddresses);
            this.RegisterProperty(ImAddress);
            this.RegisterProperty(HomeCity);
            this.RegisterProperty(WorkCity);
            this.RegisterProperty(Alias);
            this.RegisterProperty(RelevanceScore);
            this.RegisterProperty(Attributions);
            this.RegisterProperty(OfficeLocations);
            this.RegisterProperty(ImAddresses);
            this.RegisterProperty(Departments);
            this.RegisterProperty(ThirdPartyPhotoUrls);
        }

        /// <summary>
        /// constructor
        /// </summary>
        PersonaSchema()
            : super()
        {
        }
    }
